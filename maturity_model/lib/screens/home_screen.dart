// lib/screens/home_screen.dart

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

  @override
  void initState() {
    super.initState();
    // Initialize session on first load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sessionProvider.notifier).initializeSession();

      // Set initial values
      final session = ref.read(sessionProvider);
      _orgController.text = session.organizationName ?? '';
      _nameController.text = session.assessorName ?? '';
      _locationController.text = session.location ?? '';
    });
  }

  @override
  void dispose() {
    _orgController.dispose();
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final completionMap = ref.watch(allFrameworksCompletionProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine layout based on screen size
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 600;

    // Calculate grid columns based on screen size
    int gridColumns;
    double childAspectRatio;

    if (isDesktop) {
      gridColumns = 3; // 3 columns on desktop
      childAspectRatio = 1.8;
    } else if (isTablet) {
      gridColumns = 2; // 2 columns on tablet
      childAspectRatio = 1.6;
    } else {
      gridColumns = 1; // 1 column on mobile
      childAspectRatio = 2.5;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maturity Assessment Tool'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Organization info card - responsive width
            Center(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: isDesktop ? 800 : double.infinity),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Organization Information',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),

                        // Use row layout for desktop, column for mobile
                        if (isDesktop || isTablet)
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _orgController,
                                  decoration: const InputDecoration(
                                    labelText: 'Organization',
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                  onChanged: (value) {
                                    ref
                                        .read(sessionProvider.notifier)
                                        .updateOrganizationInfo(
                                          organizationName: value,
                                        );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Assessor',
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                  onChanged: (value) {
                                    ref
                                        .read(sessionProvider.notifier)
                                        .updateOrganizationInfo(
                                          assessorName: value,
                                        );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _locationController,
                                  decoration: const InputDecoration(
                                    labelText: 'Location',
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                  onChanged: (value) {
                                    ref
                                        .read(sessionProvider.notifier)
                                        .updateOrganizationInfo(
                                          location: value,
                                        );
                                  },
                                ),
                              ),
                            ],
                          )
                        else
                          Column(
                            children: [
                              TextField(
                                controller: _orgController,
                                decoration: const InputDecoration(
                                  labelText: 'Organization Name',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  ref
                                      .read(sessionProvider.notifier)
                                      .updateOrganizationInfo(
                                        organizationName: value,
                                      );
                                },
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Assessor Name',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  ref
                                      .read(sessionProvider.notifier)
                                      .updateOrganizationInfo(
                                        assessorName: value,
                                      );
                                },
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _locationController,
                                decoration: const InputDecoration(
                                  labelText: 'Location',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  ref
                                      .read(sessionProvider.notifier)
                                      .updateOrganizationInfo(
                                        location: value,
                                      );
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Framework selection
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: isDesktop ? 1200 : double.infinity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Assessment Framework',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),

                    // Framework cards in grid layout
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridColumns,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemCount: FrameworkType.values.length,
                      itemBuilder: (context, index) {
                        final type = FrameworkType.values[index];
                        final completion = completionMap[type] ?? 0.0;
                        final framework = session.frameworks[type];

                        return Card(
                          elevation: 2,
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
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Icon and title row
                                  Row(
                                    children: [
                                      Icon(
                                        _getFrameworkIcon(type),
                                        color: Theme.of(context).primaryColor,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          type.displayName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),

                                  // Description
                                  Expanded(
                                    child: Text(
                                      _getFrameworkDescription(type),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // Progress indicator
                                  LinearProgressIndicator(
                                    value: completion / 100,
                                    backgroundColor: Colors.grey[300],
                                    minHeight: 4,
                                  ),
                                  const SizedBox(height: 4),

                                  // Completion text
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${completion.toStringAsFixed(0)}%',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: _getColorForCompletion(
                                              completion),
                                        ),
                                      ),
                                      if (framework != null &&
                                          framework.unansweredCount > 0)
                                        Text(
                                          '${framework.unansweredCount} left',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFrameworkIcon(FrameworkType type) {
    switch (type) {
      case FrameworkType.is4hInstitutional:
        return Icons.local_hospital;
      case FrameworkType.is4hCountry:
        return Icons.flag;
      case FrameworkType.eccmFacility:
        return Icons.business;
      case FrameworkType.eccmOrganization:
        return Icons.corporate_fare;
      case FrameworkType.bpmn:
        return Icons.account_tree;
      case FrameworkType.adb:
        return Icons.trending_up;
    }
  }

  String _getFrameworkDescription(FrameworkType type) {
    switch (type) {
      case FrameworkType.is4hInstitutional:
        return 'For healthcare institutions';
      case FrameworkType.is4hCountry:
        return 'For country-level systems';
      case FrameworkType.eccmFacility:
        return 'Facility-level capabilities';
      case FrameworkType.eccmOrganization:
        return 'Organization-level capabilities';
      case FrameworkType.bpmn:
        return 'Business process maturity';
      case FrameworkType.adb:
        return 'Digital health readiness';
    }
  }

  Color _getColorForCompletion(double completion) {
    if (completion == 0) return Colors.grey;
    if (completion < 25) return Colors.red;
    if (completion < 50) return Colors.orange;
    if (completion < 75) return Colors.yellow[700]!;
    return Colors.green;
  }
}
