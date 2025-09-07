// lib/screens/home_screen.dart

import 'dart:async' show Timer;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _orgController = TextEditingController();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();

  // Debounce timer for text field updates
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _orgController.dispose();
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _onTextFieldChanged(String value, void Function(String) updateFunction) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      updateFunction(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    // Sync controllers with state
    if (_orgController.text != (session.organizationName ?? '')) {
      _orgController.text = session.organizationName ?? '';
    }
    if (_nameController.text != (session.assessorName ?? '')) {
      _nameController.text = session.assessorName ?? '';
    }
    if (_locationController.text != (session.location ?? '')) {
      _locationController.text = session.location ?? '';
    }

    // Determine container max width based on screen size, not text size
    final containerMaxWidth = math.min(1400.0, screenWidth * 0.9);

    return Scaffold(
      appBar: AppBar(
        title: const Text('IS4H Maturity Assessment Tool'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: containerMaxWidth,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth > 600 ? 24.0 : 16.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Organization Info Section
                _buildOrganizationSection(context),

                const SizedBox(height: 24),

                // Framework Selection Title
                Text(
                  'Select IS4H Assessment Framework',
                  style: textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // Framework Cards
                _buildFrameworkCards(context, containerMaxWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrganizationSection(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive breakpoint for row layout
    final useRowLayout = screenWidth > 800;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Organization Information',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            // Responsive layout for text fields
            useRowLayout
                ? Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          context: context,
                          controller: _orgController,
                          label: 'Organization',
                          isCompact: true,
                          onChanged: (value) => _onTextFieldChanged(
                            value,
                            (v) => ref
                                .read(sessionProvider.notifier)
                                .updateOrganizationInfo(organizationName: v),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          context: context,
                          controller: _nameController,
                          label: 'Assessor',
                          isCompact: true,
                          onChanged: (value) => _onTextFieldChanged(
                            value,
                            (v) => ref
                                .read(sessionProvider.notifier)
                                .updateOrganizationInfo(assessorName: v),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          context: context,
                          controller: _locationController,
                          label: 'Location',
                          isCompact: true,
                          onChanged: (value) => _onTextFieldChanged(
                            value,
                            (v) => ref
                                .read(sessionProvider.notifier)
                                .updateOrganizationInfo(location: v),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      _buildTextField(
                        context: context,
                        controller: _orgController,
                        label: 'Organization',
                        isCompact: true,
                        onChanged: (value) => _onTextFieldChanged(
                          value,
                          (v) => ref
                              .read(sessionProvider.notifier)
                              .updateOrganizationInfo(organizationName: v),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        context: context,
                        controller: _nameController,
                        label: 'Assessor',
                        isCompact: true,
                        onChanged: (value) => _onTextFieldChanged(
                          value,
                          (v) => ref
                              .read(sessionProvider.notifier)
                              .updateOrganizationInfo(assessorName: v),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        context: context,
                        controller: _locationController,
                        label: 'Location',
                        isCompact: true,
                        onChanged: (value) => _onTextFieldChanged(
                          value,
                          (v) => ref
                              .read(sessionProvider.notifier)
                              .updateOrganizationInfo(location: v),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required Function(String) onChanged,
    bool isCompact = false,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: isCompact ? textTheme.bodySmall : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: isCompact ? textTheme.bodySmall : null,
        isDense: isCompact,
        contentPadding: isCompact
            ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
            : null,
      ),
    );
  }

  Widget _buildFrameworkCards(BuildContext context, double containerWidth) {
    final completionMap = ref.read(allFrameworksCompletionProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine layout based on screen size
    final bool useRowLayout = screenWidth > 768;

    // Calculate card width based on container and layout
    double cardWidth;
    if (useRowLayout) {
      // Two cards side by side with spacing
      final spacing = 24.0;
      cardWidth =
          (containerWidth - spacing * 3) / 2; // Account for padding and gap
      cardWidth = math.min(cardWidth, 600); // Max width per card
    } else {
      // Single column on mobile
      cardWidth = containerWidth - 32; // Account for padding
    }

    final institutionalCard = SizedBox(
      width: cardWidth,
      child: _FrameworkCard(
        type: FrameworkType.is4hInstitutional,
        completion: completionMap[FrameworkType.is4hInstitutional] ?? 0.0,
      ),
    );

    final countryCard = SizedBox(
      width: cardWidth,
      child: _FrameworkCard(
        type: FrameworkType.is4hCountry,
        completion: completionMap[FrameworkType.is4hCountry] ?? 0.0,
      ),
    );

    if (useRowLayout) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          institutionalCard,
          const SizedBox(width: 24),
          countryCard,
        ],
      );
    } else {
      return Column(
        children: [
          institutionalCard,
          const SizedBox(height: 16),
          countryCard,
        ],
      );
    }
  }
}

// Framework Card Widget
class _FrameworkCard extends ConsumerWidget {
  final FrameworkType type;
  final double completion;

  const _FrameworkCard({
    required this.type,
    required this.completion,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final framework = ref.watch(frameworkProvider(type));
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive icon sizing
    final iconSize = screenWidth > 768 ? 48.0 : 40.0;

    return Card(
      elevation: theme.cardTheme.elevation,
      child: InkWell(
        onTap: framework != null
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssessmentScreen(
                      frameworkType: type,
                    ),
                  ),
                );
              }
            : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and Title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      type == FrameworkType.is4hInstitutional
                          ? Icons.local_hospital
                          : Icons.flag,
                      color: theme.primaryColor,
                      size: iconSize,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type == FrameworkType.is4hInstitutional
                              ? 'Institutional'
                              : 'Country',
                          style: textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          type == FrameworkType.is4hInstitutional
                              ? 'Healthcare Facilities'
                              : 'National Health Systems',
                          style: textTheme.titleSmall?.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Description
              Text(
                type == FrameworkType.is4hInstitutional
                    ? 'Comprehensive assessment for healthcare facilities, hospitals, and institutions to evaluate information systems maturity.'
                    : 'National and regional framework for evaluating country-level health information systems readiness.',
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[800],
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 16),

              // Progress Section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress',
                          style: textTheme.titleSmall,
                        ),
                        Text(
                          '${completion.toStringAsFixed(1)}%',
                          style: textTheme.headlineSmall?.copyWith(
                            color: _getColorForCompletion(completion),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: completion / 100,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getColorForCompletion(completion),
                        ),
                        minHeight: 8,
                      ),
                    ),
                    if (framework != null && framework.unansweredCount > 0) ...[
                      const SizedBox(height: 6),
                      Text(
                        '${framework.unansweredCount} questions remaining',
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Start Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: framework != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssessmentScreen(
                                frameworkType: type,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    completion > 0 ? 'Continue Assessment' : 'Start Assessment',
                    style: textTheme.labelLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorForCompletion(double completion) {
    if (completion == 0) return Colors.grey[600]!;
    if (completion < 25) return Colors.red;
    if (completion < 50) return Colors.orange;
    if (completion < 75) return Colors.amber[700]!;
    return Colors.green;
  }
}
