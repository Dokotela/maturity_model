// This can go in its own file: lib/widgets/domain_view.dart
// Or stay in assessment_screen.dart as a public class

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

    // For other frameworks, use standard question view
    return _StandardDomainView(
      domain: domain,
      frameworkType: frameworkType,
    );
  }
}

/// Standard domain view for non-BPMN frameworks
class _StandardDomainView extends StatefulWidget {
  final Domain domain;
  final FrameworkType frameworkType;

  const _StandardDomainView({
    required this.domain,
    required this.frameworkType,
  });

  @override
  State<_StandardDomainView> createState() => _StandardDomainViewState();
}

class _StandardDomainViewState extends State<_StandardDomainView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      child: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        children: [
          // Domain header
          _DomainHeader(domain: widget.domain),
          const SizedBox(height: 16),

          // Subdomains with questions
          ...widget.domain.subdomains.map((subdomain) {
            return _SubdomainSection(
              subdomain: subdomain,
              frameworkType: widget.frameworkType,
            );
          }),
        ],
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

/// Subdomain section with expandable tile
class _SubdomainSection extends StatelessWidget {
  final Subdomain subdomain;
  final FrameworkType frameworkType;

  const _SubdomainSection({
    required this.subdomain,
    required this.frameworkType,
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
          initiallyExpanded: true,
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
          children: subdomain.items
              .map((item) => AssessmentItemWidget(
                    item: item,
                    frameworkType: frameworkType,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
