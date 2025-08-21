// lib/screens/assessment_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart';

class AssessmentsListScreen extends ConsumerWidget {
  const AssessmentsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Using read since we rebuild on navigation anyway
    final completionMap = ref.read(allFrameworksCompletionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Assessment'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // IS4H Section
          const _SectionHeader(
            title: 'IS4H Assessments',
            subtitle: 'Comprehensive Information Systems for Health',
          ),
          _FrameworkTile(
            type: FrameworkType.is4hInstitutional,
            completion: completionMap[FrameworkType.is4hInstitutional] ?? 0.0,
            icon: Icons.local_hospital,
          ),
          _FrameworkTile(
            type: FrameworkType.is4hCountry,
            completion: completionMap[FrameworkType.is4hCountry] ?? 0.0,
            icon: Icons.flag,
          ),

          const SizedBox(height: 24),

          // ECCM Section
          const _SectionHeader(
            title: 'ECCM Assessments',
            subtitle: 'Essential Capabilities Maturity Model',
          ),
          _FrameworkTile(
            type: FrameworkType.eccmFacility,
            completion: completionMap[FrameworkType.eccmFacility] ?? 0.0,
            icon: Icons.business,
          ),
          _FrameworkTile(
            type: FrameworkType.eccmOrganization,
            completion: completionMap[FrameworkType.eccmOrganization] ?? 0.0,
            icon: Icons.corporate_fare,
          ),

          const SizedBox(height: 24),

          // Other Frameworks Section
          const _SectionHeader(
            title: 'Other Frameworks',
            subtitle: 'Additional assessment tools',
          ),
          _FrameworkTile(
            type: FrameworkType.bpmn,
            completion: completionMap[FrameworkType.bpmn] ?? 0.0,
            icon: Icons.account_tree,
          ),
          _FrameworkTile(
            type: FrameworkType.adb,
            completion: completionMap[FrameworkType.adb] ?? 0.0,
            icon: Icons.trending_up,
          ),
        ],
      ),
    );
  }
}

// Separate const widget for section headers - never rebuilds
class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }
}

// Separate widget for framework tiles - only rebuilds when its specific data changes
class _FrameworkTile extends ConsumerWidget {
  final FrameworkType type;
  final double completion;
  final IconData icon;

  const _FrameworkTile({
    required this.type,
    required this.completion,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only watch this specific framework, not all of them
    final framework = ref.watch(frameworkProvider(type));
    final isLoaded = framework != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              Theme.of(context).primaryColor.withValues(alpha: 0.1),
          child: Icon(icon, color: Theme.of(context).primaryColor),
        ),
        title: Text(type.displayName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: completion / 100,
              backgroundColor: Colors.grey[300],
              minHeight: 6,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${completion.toStringAsFixed(1)}% Complete'),
                if (isLoaded && framework.unansweredCount > 0)
                  Text(
                    '${framework.unansweredCount} questions remaining',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: isLoaded
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssessmentScreen(frameworkType: type),
                  ),
                );
              }
            : null,
      ),
    );
  }
}
