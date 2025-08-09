// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaturityAssessmentApp(),
    ),
  );
}

class MaturityAssessmentApp extends StatelessWidget {
  const MaturityAssessmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthcare Maturity Assessment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 2,
        ),
        cardTheme: const CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      home: const MainNavigationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  ConsumerState<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.assessment_outlined),
      selectedIcon: Icon(Icons.assessment),
      label: 'Assessments',
    ),
    NavigationDestination(
      icon: Icon(Icons.analytics_outlined),
      selectedIcon: Icon(Icons.analytics),
      label: 'Results',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const HomeScreen(),
          const AssessmentsListScreen(),
          const ResultsScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: _destinations,
      ),
    );
  }
}

// lib/screens/assessments_list_screen.dart

class AssessmentsListScreen extends ConsumerWidget {
  const AssessmentsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completionMap = ref.watch(allFrameworksCompletionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Assessment'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // IS4H Section
          _buildSectionHeader(context, 'IS4H Assessments',
              'Comprehensive Information Systems for Health'),
          _buildFrameworkTile(
            context,
            ref,
            FrameworkType.is4hInstitutional,
            completionMap[FrameworkType.is4hInstitutional] ?? 0.0,
            Icons.local_hospital,
          ),
          _buildFrameworkTile(
            context,
            ref,
            FrameworkType.is4hCountry,
            completionMap[FrameworkType.is4hCountry] ?? 0.0,
            Icons.flag,
          ),

          const SizedBox(height: 24),

          // ECCM Section
          _buildSectionHeader(context, 'ECCM Assessments',
              'Essential Capabilities Maturity Model'),
          _buildFrameworkTile(
            context,
            ref,
            FrameworkType.eccmFacility,
            completionMap[FrameworkType.eccmFacility] ?? 0.0,
            Icons.business,
          ),
          _buildFrameworkTile(
            context,
            ref,
            FrameworkType.eccmOrganization,
            completionMap[FrameworkType.eccmOrganization] ?? 0.0,
            Icons.corporate_fare,
          ),

          const SizedBox(height: 24),

          // Other Frameworks Section
          _buildSectionHeader(
              context, 'Other Frameworks', 'Additional assessment tools'),
          _buildFrameworkTile(
            context,
            ref,
            FrameworkType.bpmn,
            completionMap[FrameworkType.bpmn] ?? 0.0,
            Icons.account_tree,
          ),
          _buildFrameworkTile(
            context,
            ref,
            FrameworkType.adb,
            completionMap[FrameworkType.adb] ?? 0.0,
            Icons.trending_up,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, String subtitle) {
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

  Widget _buildFrameworkTile(
    BuildContext context,
    WidgetRef ref,
    FrameworkType type,
    double completion,
    IconData icon,
  ) {
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

// lib/screens/results_screen.dart

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completionMap = ref.watch(allFrameworksCompletionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results & Analytics'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Overall Progress Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overall Progress',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  // Calculate overall average
                  Builder(builder: (context) {
                    final activeFrameworks = completionMap.entries
                        .where((e) => e.value > 0)
                        .toList();

                    final overallAverage = activeFrameworks.isEmpty
                        ? 0.0
                        : activeFrameworks
                                .map((e) => e.value)
                                .reduce((a, b) => a + b) /
                            activeFrameworks.length;

                    return Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: CircularProgressIndicator(
                                    value: overallAverage / 100,
                                    strokeWidth: 15,
                                    backgroundColor: Colors.grey[300],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _getColorForCompletion(overallAverage),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${overallAverage.toStringAsFixed(1)}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      'Complete',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${activeFrameworks.length} of ${FrameworkType.values.length} frameworks started',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Individual Framework Results
          Text(
            'Framework Results',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),

          ...completionMap.entries.where((e) => e.value > 0).map((entry) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(entry.key.displayName),
                subtitle: LinearProgressIndicator(
                  value: entry.value / 100,
                  backgroundColor: Colors.grey[300],
                ),
                trailing: Text(
                  '${entry.value.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () {
                  // TODO: Navigate to detailed results view with spider graph
                },
              ),
            );
          }),

          if (completionMap.values.every((v) => v == 0))
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'No assessments started yet.\nSelect an assessment to begin.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getColorForCompletion(double completion) {
    if (completion < 25) return Colors.red;
    if (completion < 50) return Colors.orange;
    if (completion < 75) return Colors.yellow[700]!;
    return Colors.green;
  }
}

// lib/screens/settings_screen.dart

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Data Management Section
          Text(
            'Data Management',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.download),
                  title: const Text('Export Data'),
                  subtitle: const Text('Download your assessment data as CSV'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _exportData(context, ref),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.upload),
                  title: const Text('Import Data'),
                  subtitle: const Text('Load previously saved assessment data'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _importData(context, ref),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: const Text('Clear All Data'),
                  subtitle: const Text('Reset all assessments and start fresh'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _clearData(context, ref),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Session Info Section
          Text(
            'Session Information',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Session ID', session.sessionId),
                  _buildInfoRow('Created', _formatDateTime(session.createdAt)),
                  _buildInfoRow(
                      'Last Modified', _formatDateTime(session.lastModified)),
                  _buildInfoRow('Active Frameworks',
                      '${session.frameworks.length} loaded'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // About Section
          Text(
            'About',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Healthcare Maturity Assessment Tool',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Version 1.0.0'),
                  SizedBox(height: 8),
                  Text(
                    'A comprehensive tool for assessing healthcare information '
                    'system maturity across multiple frameworks including IS4H, '
                    'ECCM, BPMN, and ADB standards.',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
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
