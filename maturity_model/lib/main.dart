import 'package:creator/creator.dart';
import 'package:flutter/material.dart';
import 'package:maturity_model/domain_view.dart';
import 'package:maturity_model/home.dart';
import 'package:maturity_model/organizational_view.dart';

import 'generate/content.dart';

void main() => runApp(CreatorGraph(child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
      home: DefaultTabController(length: 7, child: TabScaffold()));
}

class TabScaffold extends StatefulWidget {
  const TabScaffold({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabScaffoldState();
}

class _TabScaffoldState extends State<TabScaffold>
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
