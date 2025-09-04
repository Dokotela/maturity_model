// lib/screens/home_screen.dart

import 'dart:async' show Timer;

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

    // Calculate spacing based on current text scale
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IS4H Maturity Assessment Tool',
          style: theme.appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: baseSpacing * 87.5, // Relative to text size
            ),
            padding: EdgeInsets.all(baseSpacing * 0.75),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Organization Info Section
                _buildOrganizationSection(context),

                SizedBox(height: baseSpacing * 1.25),

                // Framework Selection Title
                Text(
                  'Select IS4H Assessment Framework',
                  style: textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: baseSpacing * 1),

                // Framework Cards - no Expanded needed in ScrollView
                _buildFrameworkCards(context, screenWidth),
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
    final baseSpacing = textTheme.bodyMedium!.fontSize!;
    final screenWidth = MediaQuery.of(context).size.width;
    final useRowLayout =
        screenWidth > baseSpacing * 50; // ~800px at normal scale

    return Card(
      child: Padding(
        padding: EdgeInsets.all(baseSpacing * 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Organization Information',
              style: textTheme.titleLarge,
            ),
            SizedBox(height: baseSpacing * 0.75),

            // Responsive layout for text fields
            useRowLayout
                ? Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          context: context,
                          controller: _orgController,
                          label: 'Organization',
                          onChanged: (value) => _onTextFieldChanged(
                            value,
                            (v) => ref
                                .read(sessionProvider.notifier)
                                .updateOrganizationInfo(organizationName: v),
                          ),
                        ),
                      ),
                      SizedBox(width: baseSpacing * 1.5),
                      Expanded(
                        child: _buildTextField(
                          context: context,
                          controller: _nameController,
                          label: 'Assessor',
                          onChanged: (value) => _onTextFieldChanged(
                            value,
                            (v) => ref
                                .read(sessionProvider.notifier)
                                .updateOrganizationInfo(assessorName: v),
                          ),
                        ),
                      ),
                      SizedBox(width: baseSpacing * 1.5),
                      Expanded(
                        child: _buildTextField(
                          context: context,
                          controller: _locationController,
                          label: 'Location',
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
                        onChanged: (value) => _onTextFieldChanged(
                          value,
                          (v) => ref
                              .read(sessionProvider.notifier)
                              .updateOrganizationInfo(organizationName: v),
                        ),
                      ),
                      SizedBox(height: baseSpacing * 0.75),
                      _buildTextField(
                        context: context,
                        controller: _nameController,
                        label: 'Assessor',
                        onChanged: (value) => _onTextFieldChanged(
                          value,
                          (v) => ref
                              .read(sessionProvider.notifier)
                              .updateOrganizationInfo(assessorName: v),
                        ),
                      ),
                      SizedBox(height: baseSpacing * 0.75),
                      _buildTextField(
                        context: context,
                        controller: _locationController,
                        label: 'Location',
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
  }) {
    // Let the input decoration theme handle all styling
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  Widget _buildFrameworkCards(BuildContext context, double screenWidth) {
    final completionMap = ref.read(allFrameworksCompletionProvider);
    final baseSpacing = Theme.of(context).textTheme.bodyMedium!.fontSize!;

    // Calculate card constraints based on text size
    final cardMaxWidth = baseSpacing * 37.5; // Relative to font size
    final useVerticalLayout =
        screenWidth < baseSpacing * 56.25; // ~900px at normal scale

    if (useVerticalLayout) {
      // Stack cards vertically on smaller screens
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: cardMaxWidth),
            child: _FrameworkCard(
              type: FrameworkType.is4hInstitutional,
              completion: completionMap[FrameworkType.is4hInstitutional] ?? 0.0,
            ),
          ),
          SizedBox(height: baseSpacing * 1),
          Container(
            constraints: BoxConstraints(maxWidth: cardMaxWidth),
            child: _FrameworkCard(
              type: FrameworkType.is4hCountry,
              completion: completionMap[FrameworkType.is4hCountry] ?? 0.0,
            ),
          ),
        ],
      );
    } else {
      // Side by side on larger screens
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                constraints: BoxConstraints(maxWidth: cardMaxWidth),
                child: _FrameworkCard(
                  type: FrameworkType.is4hInstitutional,
                  completion:
                      completionMap[FrameworkType.is4hInstitutional] ?? 0.0,
                ),
              ),
            ),
            SizedBox(width: baseSpacing * 1),
            Flexible(
              child: Container(
                constraints: BoxConstraints(maxWidth: cardMaxWidth),
                child: _FrameworkCard(
                  type: FrameworkType.is4hCountry,
                  completion: completionMap[FrameworkType.is4hCountry] ?? 0.0,
                ),
              ),
            ),
          ],
        ),
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
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    // Icon size relative to headline text
    final iconSize = textTheme.headlineLarge!.fontSize! * 1.5;

    return Card(
      elevation: theme.cardTheme.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(baseSpacing * 0.75),
      ),
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
        borderRadius: BorderRadius.circular(baseSpacing * 0.75),
        child: Container(
          padding: EdgeInsets.all(baseSpacing * 1.25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and Title
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(baseSpacing * 0.75),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(baseSpacing * 0.5),
                    ),
                    child: Icon(
                      type == FrameworkType.is4hInstitutional
                          ? Icons.local_hospital
                          : Icons.flag,
                      color: theme.primaryColor,
                      size: iconSize,
                    ),
                  ),
                  SizedBox(width: baseSpacing * 1),
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
                        SizedBox(height: baseSpacing * 0.125),
                        Text(
                          type == FrameworkType.is4hInstitutional
                              ? 'Healthcare Facilities'
                              : 'National Health Systems',
                          style: textTheme.titleMedium?.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: baseSpacing * 0.75),

              // Description - no Flexible wrapper
              Text(
                type == FrameworkType.is4hInstitutional
                    ? 'Comprehensive assessment for healthcare facilities, hospitals, and institutions to evaluate information systems maturity.'
                    : 'National and regional framework for evaluating country-level health information systems readiness.',
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[800],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),

              SizedBox(height: baseSpacing * 0.75),

              // Progress Section
              Container(
                padding: EdgeInsets.all(baseSpacing * 0.75),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(baseSpacing * 0.5),
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
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: baseSpacing * 0.5),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(baseSpacing * 0.25),
                      child: LinearProgressIndicator(
                        value: completion / 100,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getColorForCompletion(completion),
                        ),
                        minHeight: baseSpacing * 0.5,
                      ),
                    ),
                    if (framework != null && framework.unansweredCount > 0) ...[
                      SizedBox(height: baseSpacing * 0.375),
                      Text(
                        '${framework.unansweredCount} questions remaining',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: baseSpacing * 0.75),

              // Start Button
              SizedBox(
                width: double.infinity,
                height: baseSpacing * 3,
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
                      borderRadius: BorderRadius.circular(baseSpacing * 0.5),
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
