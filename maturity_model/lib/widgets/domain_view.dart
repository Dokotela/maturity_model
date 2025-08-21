// lib/widgets/domain_view.dart - Optimized version

import 'package:flutter/material.dart';
import 'package:maturity_model/maturity_model.dart';

/// Main domain view widget that handles both BPMN and standard frameworks
class DomainView extends StatelessWidget {
  final Domain domain;
  final Framework framework;
  final FrameworkType frameworkType;

  const DomainView({
    super.key,
    required this.domain,
    required this.framework,
    required this.frameworkType,
  });

  @override
  Widget build(BuildContext context) {
    // For BPMN, use special rubric view
    if (frameworkType == FrameworkType.bpmn) {
      return BpmnRubricView(
        domain: domain,
        frameworkType: frameworkType,
      );
    }

    // For other frameworks, use optimized standard view
    return _OptimizedStandardDomainView(
      domain: domain,
      frameworkType: frameworkType,
    );
  }
}

/// Optimized standard domain view using ListView.builder
class _OptimizedStandardDomainView extends StatefulWidget {
  final Domain domain;
  final FrameworkType frameworkType;

  const _OptimizedStandardDomainView({
    required this.domain,
    required this.frameworkType,
  });

  @override
  State<_OptimizedStandardDomainView> createState() =>
      _OptimizedStandardDomainViewState();
}

class _OptimizedStandardDomainViewState
    extends State<_OptimizedStandardDomainView>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  // Track which subdomains are expanded
  final Map<String, bool> _expandedStates = {};

  @override
  bool get wantKeepAlive => true; // Keep state when switching tabs

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Initialize all subdomains as expanded
    for (final subdomain in widget.domain.subdomains) {
      _expandedStates[subdomain.id] = true;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    // Calculate total item count: 1 header + subdomain count
    final itemCount = 1 + widget.domain.subdomains.length;

    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          // First item is always the header
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _DomainHeader(domain: widget.domain),
            );
          }

          // Subsequent items are subdomains
          final subdomainIndex = index - 1;
          final subdomain = widget.domain.subdomains[subdomainIndex];

          return _LazySubdomainSection(
            key: ValueKey(subdomain.id),
            subdomain: subdomain,
            frameworkType: widget.frameworkType,
            isExpanded: _expandedStates[subdomain.id] ?? true,
            onExpansionChanged: (expanded) {
              setState(() {
                _expandedStates[subdomain.id] = expanded;
              });
            },
          );
        },
      ),
    );
  }
}

/// Domain header card showing progress
class _DomainHeader extends StatelessWidget {
  final Domain domain;

  const _DomainHeader({required this.domain});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              domain.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: domain.averageScore / 5,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                _getColorForScore(domain.averageScore),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Average Score: ${domain.averageScore.toStringAsFixed(1)}/5',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForScore(double score) {
    if (score < 2) return Colors.red;
    if (score < 3) return Colors.orange;
    if (score < 4) return Colors.yellow[700]!;
    return Colors.green;
  }
}

/// Lazy-loading subdomain section that only builds children when expanded
class _LazySubdomainSection extends StatelessWidget {
  final Subdomain subdomain;
  final FrameworkType frameworkType;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;

  const _LazySubdomainSection({
    super.key,
    required this.subdomain,
    required this.frameworkType,
    required this.isExpanded,
    required this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate completion status
    final answeredCount = subdomain.items
        .where((item) => item.response != null && item.response! > 0)
        .length;
    final allAnswered =
        answeredCount == subdomain.items.length && subdomain.items.isNotEmpty;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          key: ValueKey(subdomain.id),
          initiallyExpanded: isExpanded,
          maintainState: true,
          onExpansionChanged: onExpansionChanged,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: EdgeInsets.zero,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.topLeft,
          leading: allAnswered
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24,
                )
              : null,
          title: Text(
            subdomain.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: allAnswered ? Colors.green[700] : null,
            ),
          ),
          subtitle: Text(
            '$answeredCount of ${subdomain.items.length} completed',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          // Only build children when expanded
          children: isExpanded
              ? subdomain.items
                  .map((item) => AssessmentItemWidget(
                        key: ValueKey(item.id),
                        item: item,
                        frameworkType: frameworkType,
                      ))
                  .toList()
              : [],
        ),
      ),
    );
  }
}
