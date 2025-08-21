// lib/screens/assessment_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart';

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
  void initState() {
    super.initState();
    // Tab controller will be initialized in build when we know domain count
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final framework = ref.watch(frameworkProvider(widget.frameworkType));

    if (framework == null || framework.domains.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.frameworkType.displayName),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(framework == null
                  ? 'Loading framework...'
                  : 'No data found for this framework'),
            ],
          ),
        ),
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
            ? PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: _buildCustomTabBar(framework),
              )
            : null,
      ),
      body: framework.domains.length > 1
          ? TabBarView(
              controller: _tabController!,
              children: framework.domains
                  .map(
                    (domain) => _buildDomainView(domain, framework),
                  )
                  .toList(),
            )
          : _buildDomainView(framework.domains.first, framework),
    );
  }

  // Custom tab bar with better navigation hints
  Widget _buildCustomTabBar(Framework framework) {
    // Create abbreviated domain names for tabs
    String _abbreviateDomainName(String name) {
      // Special abbreviations for known long domain names
      final abbreviations = {
        'Institutional Standards/Guidelines/Policies': 'Standards & Policies',
        'Stakeholder Management': 'Stakeholders',
        'Adoption Processes': 'Adoption',
        'Privacy Security Confidentiality': 'Privacy & Security',
        'Skills and Expertise': 'Skills',
        'Knowledge Assets Tools and Automation': 'Knowledge & Tools',
        'Goals and Measurement': 'Goals & Metrics',
        'Data Management and Information Technology': 'Data & IT',
        'Management and Governance': 'Management',
        'Knowledge Management and Sharing': 'Knowledge Sharing',
        'Innovation': 'Innovation',
      };

      return abbreviations[name] ?? name;
    }

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Tab bar with custom styling
          Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: TabBar(
              controller: _tabController!,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              padding: const EdgeInsets.only(left: 48, right: 48),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              tabs: framework.domains.map((domain) {
                final tabText = _abbreviateDomainName(domain.name);
                return Tab(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      tabText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Left scroll indicator with gradient
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: IgnorePointer(
              ignoring: _currentTabIndex == 0,
              child: AnimatedOpacity(
                opacity: _currentTabIndex > 0 ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  width: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).scaffoldBackgroundColor,
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.7),
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.chevron_left,
                      size: 24,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Right scroll indicator with gradient
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: IgnorePointer(
              ignoring: _currentTabIndex >= framework.domains.length - 1,
              child: AnimatedOpacity(
                opacity:
                    _currentTabIndex < framework.domains.length - 1 ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  width: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0),
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.7),
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.chevron_right,
                      size: 24,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
                // Can track expansion state if needed later
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
      children: domain.subdomains.expand((subdomain) {
        return subdomain.items.map((item) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question header
                  Text(
                    item.questionText.isNotEmpty
                        ? item.questionText
                        : subdomain.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select the maturity level that best describes your organization:',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Display maturity levels from the maturityDescriptions map
                  _buildBpmnMaturityLevels(item),
                ],
              ),
            ),
          );
        }).toList();
      }).toList(),
    );
  }

  Widget _buildBpmnMaturityLevels(AssessmentItem item) {
    return Column(
      children: List.generate(5, (index) {
        final level = index + 1;
        final isSelected = item.response == level;

        // Get the description for this level from maturityDescriptions
        final description = item.maturityDescriptions?[level] ??
            'Level $level description not available';

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            onTap: () {
              ref
                  .read(sessionProvider.notifier)
                  .updateResponse(widget.frameworkType, item.id, level);
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : null,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Radio button
                  Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.only(right: 12, top: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey[400]!,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        : null,
                  ),
                  // Level content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Level $level',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : null,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? null : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAssessmentItem(AssessmentItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question text
          Text(
            item.questionText,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),

          // Response options based on type
          if (item.responseType == 'likert_1_5' ||
              item.responseType == 'maturity_level')
            _buildLikertScale(item)
          else if (item.responseType == 'yes_no')
            _buildYesNoButtons(item)
          else if (item.responseType == 'yes_no_planning')
            _buildYesNoPlanningButtons(item)
          else
            _buildLikertScale(item), // Default to Likert scale

          // Scoring note if available
          if (item.scoringNote != null && item.scoringNote!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              item.scoringNote!,
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLikertScale(AssessmentItem item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        final value = index + 1;
        final isSelected = item.response == value;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: ElevatedButton(
              onPressed: () {
                ref
                    .read(sessionProvider.notifier)
                    .updateResponse(widget.frameworkType, item.id, value);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey[200],
                foregroundColor: isSelected ? Colors.white : Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '$value',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildYesNoButtons(AssessmentItem item) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: ElevatedButton(
              onPressed: () {
                ref
                    .read(sessionProvider.notifier)
                    .updateResponse(widget.frameworkType, item.id, 5);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: item.response == 5
                    ? Theme.of(context).primaryColor
                    : Colors.grey[200],
                foregroundColor:
                    item.response == 5 ? Colors.white : Colors.black87,
              ),
              child: const Text('Yes'),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: ElevatedButton(
              onPressed: () {
                ref
                    .read(sessionProvider.notifier)
                    .updateResponse(widget.frameworkType, item.id, 1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: item.response == 1
                    ? Theme.of(context).primaryColor
                    : Colors.grey[200],
                foregroundColor:
                    item.response == 1 ? Colors.white : Colors.black87,
              ),
              child: const Text('No'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildYesNoPlanningButtons(AssessmentItem item) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 2),
            child: ElevatedButton(
              onPressed: () {
                ref
                    .read(sessionProvider.notifier)
                    .updateResponse(widget.frameworkType, item.id, 5);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: item.response == 5
                    ? Theme.of(context).primaryColor
                    : Colors.grey[200],
                foregroundColor:
                    item.response == 5 ? Colors.white : Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: const Text('Yes', style: TextStyle(fontSize: 13)),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: ElevatedButton(
              onPressed: () {
                ref
                    .read(sessionProvider.notifier)
                    .updateResponse(widget.frameworkType, item.id, 3);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: item.response == 3
                    ? Theme.of(context).primaryColor
                    : Colors.grey[200],
                foregroundColor:
                    item.response == 3 ? Colors.white : Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: const Text('Planning', style: TextStyle(fontSize: 13)),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: ElevatedButton(
              onPressed: () {
                ref
                    .read(sessionProvider.notifier)
                    .updateResponse(widget.frameworkType, item.id, 1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: item.response == 1
                    ? Theme.of(context).primaryColor
                    : Colors.grey[200],
                foregroundColor:
                    item.response == 1 ? Colors.white : Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: const Text('No', style: TextStyle(fontSize: 13)),
            ),
          ),
        ),
      ],
    );
  }

  Color _getColorForScore(double score) {
    if (score < 2) return Colors.red;
    if (score < 3) return Colors.orange;
    if (score < 4) return Colors.yellow[700]!;
    return Colors.green;
  }
}
