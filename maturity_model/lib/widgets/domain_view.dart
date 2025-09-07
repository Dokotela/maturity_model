// lib/widgets/domain_view.dart - IS4H Only Version

import 'package:flutter/material.dart';
import 'package:maturity_model/maturity_model.dart';

/// Main domain view widget for IS4H frameworks
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
    // Use optimized standard view for IS4H
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

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    final subdomains = widget.domain.subdomains;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1800),
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true, // Always show the scrollbar
          thickness: 12, // Make it wider
          radius: const Radius.circular(6),
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.all(baseSpacing),
            itemCount: subdomains.length,
            itemBuilder: (context, index) {
              final subdomain = subdomains[index];
              final isExpanded = _expandedStates[subdomain.id] ?? true;

              return Card(
                margin: EdgeInsets.only(bottom: baseSpacing * 0.75),
                child: Theme(
                  data: theme.copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: isExpanded,
                    onExpansionChanged: (expanded) {
                      setState(() {
                        _expandedStates[subdomain.id] = expanded;
                      });
                    },
                    title: Text(
                      subdomain.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${subdomain.items.length} questions',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    children: subdomain.items.map((item) {
                      return AssessmentItemWidget(
                        item: item,
                        frameworkType: widget.frameworkType,
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
