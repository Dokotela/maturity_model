import 'dart:convert' show jsonEncode, jsonDecode;

import 'package:flutter_riverpod/flutter_riverpod.dart' show StateNotifier, Ref;
import 'package:maturity_model/maturity_model.dart'
    show
        FrameworkType,
        AssessmentSession,
        csvLoaderProvider,
        Framework,
        csvExportProvider;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

/// State notifier for managing the assessment session
class SessionNotifier extends StateNotifier<AssessmentSession> {
  final Ref ref;
  static const String _storageKey = 'assessment_session';

  // Single source of truth for initialization
  bool _hasLoadedFrameworks = false;
  bool _isCurrentlyLoading = false;

  SessionNotifier(this.ref) : super(AssessmentSession()) {
    // Load saved session AND frameworks on initialization
    _initializeOnce();
  }

  /// Single initialization point - called ONLY from constructor
  Future<void> _initializeOnce() async {
    if (_hasLoadedFrameworks || _isCurrentlyLoading) return;
    _isCurrentlyLoading = true;

    try {
      // First, load all frameworks (this happens exactly once)
      final loader = ref.read(csvLoaderProvider);
      final frameworks = await loader.loadAllFrameworks();

      // Then check for saved responses
      final prefs = await SharedPreferences.getInstance();
      final savedData = prefs.getString(_storageKey);

      if (savedData != null) {
        final data = jsonDecode(savedData) as Map<String, dynamic>;

        // Create session with loaded frameworks
        state = AssessmentSession(
          sessionId: data['sessionId'] ??
              DateTime.now().millisecondsSinceEpoch.toString(),
          createdAt: data['createdAt'] != null
              ? DateTime.parse(data['createdAt'])
              : DateTime.now(),
          organizationName: data['organizationName'],
          assessorName: data['assessorName'],
          location: data['location'],
          additionalNotes: data['additionalNotes'],
          frameworks: frameworks, // Use the loaded frameworks
        );

        // Apply saved responses to the frameworks
        if (data['responses'] != null) {
          _applyResponses(data['responses'] as Map<String, dynamic>);
        }
      } else {
        // No saved data, just use the loaded frameworks
        state = AssessmentSession(frameworks: frameworks);
      }

      _hasLoadedFrameworks = true;
    } catch (e) {
      print('Error during initialization: $e');
      // Even on error, create basic session with loaded frameworks
      state = AssessmentSession();
    } finally {
      _isCurrentlyLoading = false;
    }
  }

  /// Get a framework (already loaded, just return it)
  Framework? getFramework(FrameworkType type) {
    return state.frameworks[type];
  }

  /// Check if frameworks are loaded
  bool get areFrameworksLoaded => _hasLoadedFrameworks;

  /// Update organization info
  void updateOrganizationInfo({
    String? organizationName,
    String? assessorName,
    String? location,
    String? additionalNotes,
  }) {
    state = AssessmentSession(
      sessionId: state.sessionId,
      createdAt: state.createdAt,
      organizationName: organizationName ?? state.organizationName,
      assessorName: assessorName ?? state.assessorName,
      location: location ?? state.location,
      additionalNotes: additionalNotes ?? state.additionalNotes,
      frameworks: state.frameworks, // Keep the same framework instances
    );

    _saveToLocalStorage();
  }

  /// Update a response for a specific item
  void updateResponse(
    FrameworkType frameworkType,
    String itemId,
    int? response, {
    String? comment,
  }) {
    final framework = state.frameworks[frameworkType];
    if (framework == null) return;

    // Find and update the item
    bool updated = false;
    for (final domain in framework.domains) {
      for (final subdomain in domain.subdomains) {
        for (final item in subdomain.items) {
          if (item.id == itemId) {
            item.setResponse(response, comment: comment);
            updated = true;
            break;
          }
        }
        if (updated) break;
      }
      if (updated) break;
    }

    if (updated) {
      // Update timestamps
      framework.lastModified = DateTime.now();

      // Create new state to trigger rebuilds
      state = state.copyWith(
        lastModified: DateTime.now(),
        frameworks: state.frameworks, // Same framework instances
      );

      // Auto-save responses only
      _saveToLocalStorage();
    }
  }

  /// Clear all responses for a framework
  void clearFrameworkResponses(FrameworkType frameworkType) {
    final framework = state.frameworks[frameworkType];
    if (framework == null) return;

    for (final domain in framework.domains) {
      for (final subdomain in domain.subdomains) {
        for (final item in subdomain.items) {
          item.response = null;
          item.comment = null;
          item.responseTimestamp = null;
        }
      }
    }

    state = AssessmentSession(
      sessionId: state.sessionId,
      createdAt: state.createdAt,
      organizationName: state.organizationName,
      assessorName: state.assessorName,
      location: state.location,
      additionalNotes: state.additionalNotes,
      frameworks: state.frameworks, // Same framework instances
    );

    _saveToLocalStorage();
  }

  /// Reset entire session (keeps frameworks, clears responses)
  Future<void> resetSession() async {
    // Clear all responses but keep frameworks
    for (final framework in state.frameworks.values) {
      for (final domain in framework.domains) {
        for (final subdomain in domain.subdomains) {
          for (final item in subdomain.items) {
            item.response = null;
            item.comment = null;
            item.responseTimestamp = null;
          }
        }
      }
    }

    // Create fresh session with same frameworks
    state = AssessmentSession(
      frameworks: state.frameworks, // Reuse the same framework instances
    );

    await _saveToLocalStorage();
  }

  /// Export session to CSV string
  String exportToCsv() {
    final exporter = ref.read(csvExportProvider);
    return exporter.exportSessionToCsv(state);
  }

  /// Import session from CSV string
  Future<bool> importFromCsv(String csvContent) async {
    try {
      final exporter = ref.read(csvExportProvider);
      final importedSession = await exporter.importSessionFromCsv(csvContent);

      if (importedSession != null) {
        // Use our already-loaded frameworks, just apply the responses
        state = AssessmentSession(
          sessionId: importedSession.sessionId,
          createdAt: importedSession.createdAt,
          organizationName: importedSession.organizationName,
          assessorName: importedSession.assessorName,
          location: importedSession.location,
          additionalNotes: importedSession.additionalNotes,
          frameworks: state.frameworks, // Keep our frameworks
        );

        // Apply the imported responses
        for (final entry in importedSession.frameworks.entries) {
          final importedFramework = entry.value;
          final ourFramework = state.frameworks[entry.key];
          if (ourFramework != null) {
            for (final domain in ourFramework.domains) {
              for (final subdomain in domain.subdomains) {
                for (final item in subdomain.items) {
                  // Find matching item in imported data
                  final importedItem = importedFramework.domains
                      .expand((d) => d.subdomains)
                      .expand((s) => s.items)
                      .firstWhere((i) => i.id == item.id, orElse: () => item);

                  item.response = importedItem.response;
                  item.comment = importedItem.comment;
                  item.responseTimestamp = importedItem.responseTimestamp;
                }
              }
            }
          }
        }

        await _saveToLocalStorage();
        return true;
      }
      return false;
    } catch (e) {
      print('Error importing CSV: $e');
      return false;
    }
  }

  /// Save ONLY responses to localStorage (not frameworks)
  Future<void> _saveToLocalStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Save only metadata and responses, not framework definitions
      final storageData = {
        'sessionId': state.sessionId,
        'createdAt': state.createdAt.toIso8601String(),
        'lastModified': state.lastModified.toIso8601String(),
        'organizationName': state.organizationName,
        'assessorName': state.assessorName,
        'location': state.location,
        'additionalNotes': state.additionalNotes,
        'responses': _extractResponses(), // Only responses
      };

      await prefs.setString(_storageKey, jsonEncode(storageData));
    } catch (e) {
      print('Error saving to localStorage: $e');
    }
  }

  /// Extract responses for storage
  Map<String, dynamic> _extractResponses() {
    final responses = <String, dynamic>{};

    for (final entry in state.frameworks.entries) {
      final frameworkResponses = <String, dynamic>{};

      for (final domain in entry.value.domains) {
        for (final subdomain in domain.subdomains) {
          for (final item in subdomain.items) {
            if (item.response != null) {
              frameworkResponses[item.id] = {
                'response': item.response,
                'comment': item.comment,
                'timestamp': item.responseTimestamp?.toIso8601String(),
              };
            }
          }
        }
      }

      if (frameworkResponses.isNotEmpty) {
        responses[entry.key.name] = frameworkResponses;
      }
    }

    return responses;
  }

  /// Apply saved responses to frameworks
  void _applyResponses(Map<String, dynamic> responses) {
    for (final entry in responses.entries) {
      // Find the framework type
      final frameworkType = FrameworkType.values.firstWhere(
        (e) => e.name == entry.key,
        orElse: () => FrameworkType.is4hInstitutional,
      );

      final framework = state.frameworks[frameworkType];
      if (framework != null) {
        final frameworkResponses = entry.value as Map<String, dynamic>;

        for (final domain in framework.domains) {
          for (final subdomain in domain.subdomains) {
            for (final item in subdomain.items) {
              final savedResponse = frameworkResponses[item.id];
              if (savedResponse != null) {
                item.response = savedResponse['response'] as int?;
                item.comment = savedResponse['comment'] as String?;
                if (savedResponse['timestamp'] != null) {
                  item.responseTimestamp =
                      DateTime.tryParse(savedResponse['timestamp']);
                }
              }
            }
          }
        }
      }
    }
  }
}
