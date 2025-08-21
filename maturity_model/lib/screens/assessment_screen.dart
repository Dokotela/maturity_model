// lib/screens/assessment_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart'
    show
        FrameworkType,
        frameworkProvider,
        Framework,
        sessionProvider,
        CustomTabBar,
        DomainView;

class AssessmentScreen extends ConsumerStatefulWidget {
  final FrameworkType frameworkType;

  const AssessmentScreen({
    super.key,
    required this.frameworkType,
  });

  @override
  ConsumerState<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends ConsumerState<AssessmentScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _currentTabIndex = 0;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the session to trigger rebuilds on any change
    ref.watch(sessionProvider);
    final framework = ref.watch(frameworkProvider(widget.frameworkType));

    if (framework == null || framework.domains.isEmpty) {
      return _LoadingOrEmptyScaffold(
        frameworkType: widget.frameworkType,
        isLoading: framework == null,
      );
    }

    // Initialize tab controller with correct length
    if (_tabController == null ||
        _tabController!.length != framework.domains.length) {
      _tabController?.dispose();
      _tabController = TabController(
        length: framework.domains.length,
        vsync: this,
      );
      _tabController!.addListener(() {
        setState(() {
          _currentTabIndex = _tabController!.index;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: _AssessmentAppBarTitle(
          frameworkType: widget.frameworkType,
          framework: framework,
        ),
        bottom: framework.domains.length > 1
            ? PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: CustomTabBar(
                  tabController: _tabController!,
                  framework: framework,
                  currentTabIndex: _currentTabIndex,
                ),
              )
            : null,
      ),
      body: framework.domains.length > 1
          ? TabBarView(
              controller: _tabController!,
              children: framework.domains
                  .map((domain) => DomainView(
                        domain: domain,
                        framework: framework,
                        frameworkType: widget.frameworkType,
                      ))
                  .toList(),
            )
          : DomainView(
              domain: framework.domains.first,
              framework: framework,
              frameworkType: widget.frameworkType,
            ),
    );
  }
}

/// Loading or empty state scaffold
class _LoadingOrEmptyScaffold extends StatelessWidget {
  final FrameworkType frameworkType;
  final bool isLoading;

  const _LoadingOrEmptyScaffold({
    required this.frameworkType,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(frameworkType.displayName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              isLoading
                  ? 'Loading framework...'
                  : 'No data found for this framework',
            ),
          ],
        ),
      ),
    );
  }
}

/// App bar title with progress information
class _AssessmentAppBarTitle extends StatelessWidget {
  final FrameworkType frameworkType;
  final Framework framework;

  const _AssessmentAppBarTitle({
    required this.frameworkType,
    required this.framework,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          frameworkType.displayName,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          _buildProgressText(),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }

  String _buildProgressText() {
    final completion = framework.completionPercentage;
    final unanswered = framework.unansweredCount;

    // Count total items
    int totalItems = 0;
    int answeredItems = 0;

    for (final domain in framework.domains) {
      for (final subdomain in domain.subdomains) {
        totalItems += subdomain.items.length;
        answeredItems += subdomain.items
            .where((item) => item.response != null && item.response! > 0)
            .length;
      }
    }

    // For debugging - show the actual counts
    if (frameworkType == FrameworkType.bpmn) {
      return '$answeredItems of $totalItems answered (${completion.toStringAsFixed(1)}%)';
    }

    // For other frameworks, show the standard display
    if (unanswered == 0 && answeredItems < totalItems) {
      // There's a bug - show the real count
      final realUnanswered = totalItems - answeredItems;
      return '${completion.toStringAsFixed(1)}% Complete • $realUnanswered questions remaining';
    }

    return '${completion.toStringAsFixed(1)}% Complete • $unanswered questions remaining';
  }
}
