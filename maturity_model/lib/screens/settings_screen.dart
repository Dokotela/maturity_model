// lib/screens/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart';
import 'package:intl/intl.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(baseSpacing),
        children: [
          // Data Management Section
          Text(
            'Data Management',
            style: textTheme.titleLarge,
          ),
          SizedBox(height: baseSpacing * 0.75),
          const _DataManagementCard(),

          SizedBox(height: baseSpacing * 1.5),

          // Session Info Section - only this needs provider
          Text(
            'Session Information',
            style: textTheme.titleLarge,
          ),
          SizedBox(height: baseSpacing * 0.75),
          const _SessionInfoCard(),

          SizedBox(height: baseSpacing * 1.5),

          // About Section - completely static
          Text(
            'About',
            style: textTheme.titleLarge,
          ),
          SizedBox(height: baseSpacing * 0.75),
          const _AboutCard(),
        ],
      ),
    );
  }
}

// Data management card - needs ref for actions but doesn't watch
class _DataManagementCard extends ConsumerWidget {
  const _DataManagementCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final baseSpacing = theme.textTheme.bodyMedium!.fontSize!;

    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Export Data'),
            subtitle: const Text('Download your assessment data as CSV'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _exportData(context, ref),
          ),
          Divider(height: baseSpacing * 0.0625),
          ListTile(
            leading: const Icon(Icons.upload),
            title: const Text('Import Data'),
            subtitle: const Text('Load previously saved assessment data'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _importData(context, ref),
          ),
          Divider(height: baseSpacing * 0.0625),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text('Clear All Data'),
            subtitle: const Text('Reset all assessments and start fresh'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _clearData(context, ref),
          ),
        ],
      ),
    );
  }

  void _exportData(BuildContext context, WidgetRef ref) {
    final csvContent = ref.read(sessionProvider.notifier).exportToCsv();

    // TODO: Implement actual file download
    // For now, show a dialog with the content
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: const Text(
            'CSV export functionality will download your assessment data. '
            'This feature requires file_saver package implementation.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _importData(BuildContext context, WidgetRef ref) {
    // TODO: Implement file picker
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import Data'),
        content: const Text(
            'File import functionality will allow you to load previously '
            'saved CSV files. This feature requires file_picker package implementation.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _clearData(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data?'),
        content: const Text(
            'This will reset all assessments and clear all saved responses. '
            'This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(sessionProvider.notifier).resetSession();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All data cleared')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear Data'),
          ),
        ],
      ),
    );
  }
}

// Session info card - only watches what it needs
class _SessionInfoCard extends ConsumerWidget {
  const _SessionInfoCard();

  static final _dateFormat = DateFormat('dd/MM/yyyy HH:mm');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    // Only watch specific fields we need
    final session = ref.watch(sessionProvider.select((s) => (
          sessionId: s.sessionId,
          createdAt: s.createdAt,
          lastModified: s.lastModified,
          frameworkCount: s.frameworks.length,
        )));

    return Card(
      child: Padding(
        padding: EdgeInsets.all(baseSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoRow(label: 'Session ID', value: session.sessionId),
            _InfoRow(
                label: 'Created', value: _dateFormat.format(session.createdAt)),
            _InfoRow(
                label: 'Last Modified',
                value: _dateFormat.format(session.lastModified)),
            _InfoRow(
                label: 'Active Frameworks',
                value: '${session.frameworkCount} loaded'),
          ],
        ),
      ),
    );
  }
}

// Static info row widget
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: baseSpacing * 0.25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// About card with responsive sizing
class _AboutCard extends StatelessWidget {
  const _AboutCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(baseSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Healthcare Maturity Assessment Tool',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: baseSpacing * 0.5),
            Text(
              'Version 1.0.0',
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: baseSpacing * 0.5),
            Text(
              'A comprehensive tool for assessing healthcare information '
              'system maturity using the IS4H standards.',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
