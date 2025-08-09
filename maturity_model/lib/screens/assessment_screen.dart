// lib/screens/assessment_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart'
    show
        FrameworkType,
        Framework,
        Domain,
        AssessmentItem,
        frameworkProvider,
        frameworkCompletionProvider,
        sessionProvider;

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
  late TabController _tabController;
  int _expandedDomainIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize tab controller will be set after build when we know domain count
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final framework = ref.watch(frameworkProvider(widget.frameworkType));

    if (framework == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.frameworkType.displayName),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Initialize tab controller with correct length
    if (!mounted || _tabController.length != framework.domains.length) {
      _tabController = TabController(
        length: framework.domains.length,
        vsync: this,
      );
    }

    final completion =
        ref.watch(frameworkCompletionProvider(widget.frameworkType));
    final unanswered = framework.unansweredCount;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.frameworkType.displayName,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              '${completion.toStringAsFixed(1)}% Complete • $unanswered questions remaining',
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        bottom: framework.domains.length > 1
            ? TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: framework.domains
                    .map(
                      (domain) => Tab(text: domain.name),
                    )
                    .toList(),
              )
            : null,
      ),
      body: framework.domains.length > 1
          ? TabBarView(
              controller: _tabController,
              children: framework.domains
                  .map(
                    (domain) => _buildDomainView(domain, framework),
                  )
                  .toList(),
            )
          : _buildDomainView(framework.domains.first, framework),
    );
  }

  Widget _buildDomainView(Domain domain, Framework framework) {
    // For BPMN, use special rubric view
    if (widget.frameworkType == FrameworkType.bpmn) {
      return _buildBpmnRubricView(domain, framework);
    }

    // For other frameworks, use standard question view
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Domain header
        Card(
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
        ),
        const SizedBox(height: 16),

        // Subdomains with questions
        ...domain.subdomains.asMap().entries.map((entry) {
          final index = entry.key;
          final subdomain = entry.value;
          final isExpanded = _expandedDomainIndex == index;

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ExpansionTile(
              initiallyExpanded: index == 0,
              title: Text(
                subdomain.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${subdomain.items.where((i) => i.response != null && i.response! > 0).length}/${subdomain.items.length} answered',
              ),
              trailing: CircularProgressIndicator(
                value: subdomain.items.isEmpty
                    ? 0
                    : subdomain.items
                            .where((i) => i.response != null && i.response! > 0)
                            .length /
                        subdomain.items.length,
                strokeWidth: 3,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getColorForScore(subdomain.averageScore),
                ),
              ),
              onExpansionChanged: (expanded) {
                if (expanded) {
                  setState(() => _expandedDomainIndex = index);
                }
              },
              children: subdomain.items
                  .map(
                    (item) => _buildAssessmentItem(item),
                  )
                  .toList(),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildBpmnRubricView(Domain domain, Framework framework) {
    // Special view for BPMN rubric-style assessment
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  domain.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),

                // For BPMN, show the rubric with 5 levels
                if (domain.subdomains.isNotEmpty &&
                    domain.subdomains.first.items.isNotEmpty)
                  _buildBpmnRubricItem(domain.subdomains.first.items.first),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBpmnRubricItem(AssessmentItem item) {
    // Split the question text to show each maturity level
    final levels = item.questionText
        .split('Level')
        .skip(1)
        .map((text) => 'Level $text'.trim())
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select your organization\'s maturity level:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // Display each level as a selectable card
        ...List.generate(5, (index) {
          final level = index + 1;
          final isSelected = item.response == level;
          final levelText =
              levels.length > index ? levels[index] : 'Level $level';

          return Card(
            color: isSelected
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : null,
            child: InkWell(
              onTap: () {
                ref.read(sessionProvider.notifier).updateResponse(
                      widget.frameworkType,
                      item.id,
                      level,
                    );
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Radio<int>(
                      value: level,
                      groupValue: item.response,
                      onChanged: (value) {
                        ref.read(sessionProvider.notifier).updateResponse(
                              widget.frameworkType,
                              item.id,
                              value,
                            );
                      },
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Level $level',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(levelText),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAssessmentItem(AssessmentItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question text
          Text(
            item.questionText,
            style: const TextStyle(fontSize: 15),
          ),

          // Scoring note if available
          if (item.scoringNote != null && item.scoringNote!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              item.scoringNote!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],

          const SizedBox(height: 12),

          // Response selector
          Row(
            children: [
              const Text('Not Applicable', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 8),

              // Skip/NA button
              OutlinedButton(
                onPressed: () {
                  ref.read(sessionProvider.notifier).updateResponse(
                        widget.frameworkType,
                        item.id,
                        null,
                      );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(40, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  backgroundColor:
                      item.response == null ? Colors.grey[200] : null,
                ),
                child: const Text('Skip'),
              ),

              const SizedBox(width: 16),
              const Text('1', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 4),

              // Score buttons 1-5
              ...List.generate(5, (index) {
                final score = index + 1;
                return Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(sessionProvider.notifier).updateResponse(
                            widget.frameworkType,
                            item.id,
                            score,
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(40, 36),
                      padding: EdgeInsets.zero,
                      backgroundColor: item.response == score
                          ? _getColorForScore(score.toDouble())
                          : Colors.grey[300],
                      foregroundColor: item.response == score
                          ? Colors.white
                          : Colors.black54,
                    ),
                    child: Text('$score'),
                  ),
                );
              }),

              const SizedBox(width: 4),
              const Text('5', style: TextStyle(fontSize: 12)),
            ],
          ),

          // Comment field (optional)
          if (item.response != null && item.response! > 0) ...[
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Add a comment (optional)',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                isDense: true,
              ),
              style: const TextStyle(fontSize: 14),
              maxLines: 2,
              controller: TextEditingController(text: item.comment),
              onChanged: (value) {
                ref.read(sessionProvider.notifier).updateResponse(
                      widget.frameworkType,
                      item.id,
                      item.response,
                      comment: value,
                    );
              },
            ),
          ],
        ],
      ),
    );
  }

  Color _getColorForScore(double score) {
    if (score == 0) return Colors.grey;
    if (score < 2) return Colors.red;
    if (score < 3) return Colors.orange;
    if (score < 4) return Colors.yellow[700]!;
    return Colors.green;
  }
}
