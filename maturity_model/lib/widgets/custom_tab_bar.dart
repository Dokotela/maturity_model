// This can go in its own file: lib/widgets/custom_tab_bar.dart
// Or stay in assessment_screen.dart as a public class

import 'package:flutter/material.dart';
import 'package:maturity_model/maturity_model.dart';

/// Custom tab bar with scroll indicators for framework domains
class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final Framework framework;
  final int currentTabIndex;

  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.framework,
    required this.currentTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Tab bar with custom styling
          _TabBarContent(
            tabController: tabController,
            framework: framework,
          ),

          // Left scroll indicator
          _ScrollIndicator(
            isLeft: true,
            isVisible: currentTabIndex > 0,
          ),

          // Right scroll indicator
          _ScrollIndicator(
            isLeft: false,
            isVisible: currentTabIndex < framework.domains.length - 1,
          ),
        ],
      ),
    );
  }
}

/// The actual tab bar content
class _TabBarContent extends StatelessWidget {
  final TabController tabController;
  final Framework framework;

  const _TabBarContent({
    required this.tabController,
    required this.framework,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: TabBar(
        controller: tabController,
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
          return Tab(
            child: _TabLabel(domainName: domain.name),
          );
        }).toList(),
      ),
    );
  }
}

/// Individual tab label with abbreviation logic
class _TabLabel extends StatelessWidget {
  final String domainName;

  const _TabLabel({required this.domainName});

  static const _abbreviations = {
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

  @override
  Widget build(BuildContext context) {
    final tabText = _abbreviations[domainName] ?? domainName;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        tabText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// Scroll indicator with gradient
class _ScrollIndicator extends StatelessWidget {
  final bool isLeft;
  final bool isVisible;

  const _ScrollIndicator({
    required this.isLeft,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: isLeft ? 0 : null,
      right: isLeft ? null : 0,
      top: 0,
      bottom: 0,
      child: IgnorePointer(
        ignoring: !isVisible,
        child: AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isLeft
                    ? [
                        Theme.of(context).scaffoldBackgroundColor,
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withValues(alpha: 0.7),
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withValues(alpha: 0),
                      ]
                    : [
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withValues(alpha: 0),
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withValues(alpha: 0.7),
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: Center(
              child: Icon(
                isLeft ? Icons.chevron_left : Icons.chevron_right,
                size: 24,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
