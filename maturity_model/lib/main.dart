import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/content/content.dart';
import 'package:maturity_model/content/country_content.dart';
import 'package:maturity_model/content/institutional_content.dart';
import 'package:maturity_model/providers.dart';
import 'package:maturity_model/domain_view.dart';
import 'package:maturity_model/home.dart';
import 'package:maturity_model/organizational_view.dart';

void main() => runApp(
      ProviderScope(
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
      home: DefaultTabController(length: 7, child: TabScaffold()));
}

class TabScaffold extends ConsumerStatefulWidget {
  const TabScaffold({super.key});

  @override
  ConsumerState<TabScaffold> createState() => _TabScaffoldState();
}

class _TabScaffoldState extends ConsumerState<TabScaffold>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 7, vsync: this);

  @override
  Widget build(BuildContext context) {
    Tab newTab(IconData icon, String text) => Tab(
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            Expanded(child: Text(text, textAlign: TextAlign.center)),
          ],
        ));

    // Watch the mmLevel provider
    final mmLevel = ref.watch(mmLevelProvider);
    final content =
        mmLevel == MmLevel.country ? countryContent : institutionalContent;

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            newTab(Icons.home, 'Home'),
            newTab(Icons.apartment, 'Organizational Results'),
            newTab(Icons.devices, 'Data Management and Information Technology'),
            newTab(Icons.manage_accounts, 'Management and Governance'),
            newTab(Icons.library_books, 'Knowledge Management and Sharing'),
            newTab(Icons.lightbulb_outline, 'Innovation'),
            newTab(Icons.menu_book, 'Glossary'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TabBarView(
          controller: _tabController,
          children: [
            HomeView(_tabController),
            OrganizationalView(content),
            DomainView(content.domains[0], true),
            DomainView(content.domains[1], false),
            DomainView(content.domains[2], false),
            DomainView(content.domains[3], false),
            const Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
