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

  SessionNotifier(this.ref) : super(AssessmentSession()) {
    // Load saved session on initialization
    _loadFromLocalStorage();
  }

  /// Initialize a new session with all frameworks
  Future<void> initializeSession() async {
    final loader = ref.read(csvLoaderProvider);
    final frameworks = await loader.loadAllFrameworks();

    state = AssessmentSession(
      frameworks: frameworks,
    );

    // Auto-save after initialization
    await _saveToLocalStorage();
  }

  /// Load a specific framework
  Future<void> loadFramework(FrameworkType type) async {
    final loader = ref.read(csvLoaderProvider);
    final framework = await loader.loadFramework(type);

    if (framework != null) {
      final newFrameworks =
          Map<FrameworkType, Framework>.from(state.frameworks);
      newFrameworks[type] = framework;

      state = AssessmentSession(
        sessionId: state.sessionId,
        createdAt: state.createdAt,
        organizationName: state.organizationName,
        assessorName: state.assessorName,
        location: state.location,
        additionalNotes: state.additionalNotes,
        frameworks: newFrameworks,
      );

      await _saveToLocalStorage();
    }
  }

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
      frameworks: state.frameworks,
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

    // Find and update the item (mutating in place is fine)
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

      // Create new state using copyWith - this creates a new AssessmentSession instance
      // which triggers Riverpod to rebuild
      state = state.copyWith(
        lastModified: DateTime.now(),
        frameworks: state.frameworks, // Same map reference is fine
      );

      // Auto-save
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
      frameworks: Map.from(state.frameworks),
    );

    _saveToLocalStorage();
  }

  /// Reset entire session
  Future<void> resetSession() async {
    state = AssessmentSession();
    await initializeSession();
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
        state = importedSession;
        await _saveToLocalStorage();
        return true;
      }
      return false;
    } catch (e) {
      print('Error importing CSV: $e');
      return false;
    }
  }

  /// Save to localStorage
  Future<void> _saveToLocalStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Create a simplified version for storage (just responses, not full framework definitions)
      final storageData = {
        'sessionId': state.sessionId,
        'createdAt': state.createdAt.toIso8601String(),
        'lastModified': state.lastModified.toIso8601String(),
        'organizationName': state.organizationName,
        'assessorName': state.assessorName,
        'location': state.location,
        'additionalNotes': state.additionalNotes,
        'responses': _extractResponses(),
      };

      await prefs.setString(_storageKey, jsonEncode(storageData));
    } catch (e) {
      print('Error saving to localStorage: $e');
    }
  }

  /// Load from localStorage
  Future<void> _loadFromLocalStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedData = prefs.getString(_storageKey);

      if (savedData != null) {
        final data = jsonDecode(savedData) as Map<String, dynamic>;

        // Load frameworks first
        await initializeSession();

        // Then apply saved data
        state = AssessmentSession(
          sessionId: data['sessionId'] ?? state.sessionId,
          createdAt: data['createdAt'] != null
              ? DateTime.parse(data['createdAt'])
              : state.createdAt,
          organizationName: data['organizationName'],
          assessorName: data['assessorName'],
          location: data['location'],
          additionalNotes: data['additionalNotes'],
          frameworks: state.frameworks,
        );

        // Apply saved responses
        if (data['responses'] != null) {
          _applyResponses(data['responses'] as Map<String, dynamic>);
        }
      } else {
        // No saved session, initialize new one
        await initializeSession();
      }
    } catch (e) {
      print('Error loading from localStorage: $e');
      // If loading fails, start fresh
      await initializeSession();
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
