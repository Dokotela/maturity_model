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
  @override
  void initState() {
    super.initState();
    // Initialize session on first load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sessionProvider.notifier).initializeSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final completionMap = ref.watch(allFrameworksCompletionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maturity Assessment Tool'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Organization info card
          Card(
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
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Organization Name',
                      border: OutlineInputBorder(),
                    ),
                    controller:
                        TextEditingController(text: session.organizationName),
                    onChanged: (value) {
                      ref.read(sessionProvider.notifier).updateOrganizationInfo(
                            organizationName: value,
                          );
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Assessor Name',
                      border: OutlineInputBorder(),
                    ),
                    controller:
                        TextEditingController(text: session.assessorName),
                    onChanged: (value) {
                      ref.read(sessionProvider.notifier).updateOrganizationInfo(
                            assessorName: value,
                          );
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(text: session.location),
                    onChanged: (value) {
                      ref.read(sessionProvider.notifier).updateOrganizationInfo(
                            location: value,
                          );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Framework selection
          Text(
            'Select Assessment Framework',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),

          // Framework cards
          ...FrameworkType.values.map((type) {
            final completion = completionMap[type] ?? 0.0;
            final framework = session.frameworks[type];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(type.displayName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(_getFrameworkDescription(type)),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: completion / 100,
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(height: 4),
                    Text('${completion.toStringAsFixed(1)}% Complete'),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
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
              ),
            );
          }),
        ],
      ),
    );
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
}
