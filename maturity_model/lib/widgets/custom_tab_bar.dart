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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    return Container(
      height: baseSpacing * 3,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: Offset(0, baseSpacing * 0.125),
            blurRadius: baseSpacing * 0.25,
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    return Theme(
      data: theme.copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        padding: EdgeInsets.only(
          left: baseSpacing * 3,
          right: baseSpacing * 3,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: baseSpacing * 0.1875,
        labelColor: theme.primaryColor,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.normal,
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    final tabText = _abbreviations[domainName] ?? domainName;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: baseSpacing * 0.75),
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

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
            width: baseSpacing * 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isLeft
                    ? [
                        theme.scaffoldBackgroundColor,
                        theme.scaffoldBackgroundColor.withValues(alpha: 0.7),
                        theme.scaffoldBackgroundColor.withValues(alpha: 0),
                      ]
                    : [
                        theme.scaffoldBackgroundColor.withValues(alpha: 0),
                        theme.scaffoldBackgroundColor.withValues(alpha: 0.7),
                        theme.scaffoldBackgroundColor,
                      ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: Center(
              child: Icon(
                isLeft ? Icons.chevron_left : Icons.chevron_right,
                size: baseSpacing * 1.5,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
