// lib/screens/home_screen.dart

import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _orgController = TextEditingController();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // DON'T call initializeSession here - it's already done in SessionNotifier constructor

    // Just set initial values from current session
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final session = ref.read(sessionProvider);
      _orgController.text = session.organizationName ?? '';
      _nameController.text = session.assessorName ?? '';
      _locationController.text = session.location ?? '';
    });
  }

  @override
  void dispose() {
    _orgController.dispose();
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // Debounce timer for text field updates
  Timer? _debounceTimer;

  void _onTextFieldChanged(String value, void Function(String) updateFunction) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      updateFunction(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine layout based on screen size
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 600;

    // Calculate grid columns based on screen size
    int gridColumns;
    double childAspectRatio;

    if (isDesktop) {
      gridColumns = 3;
      childAspectRatio = 1.8;
    } else if (isTablet) {
      gridColumns = 2;
      childAspectRatio = 1.6;
    } else {
      gridColumns = 1;
      childAspectRatio = 2.5;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maturity Assessment Tool'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Organization info card
            OrganizationInfoCard(
              orgController: _orgController,
              nameController: _nameController,
              locationController: _locationController,
              isDesktop: isDesktop,
              isTablet: isTablet,
              onOrgChanged: (value) => _onTextFieldChanged(
                value,
                (v) =>
                    ref.read(sessionProvider.notifier).updateOrganizationInfo(
                          organizationName: v,
                        ),
              ),
              onNameChanged: (value) => _onTextFieldChanged(
                value,
                (v) =>
                    ref.read(sessionProvider.notifier).updateOrganizationInfo(
                          assessorName: v,
                        ),
              ),
              onLocationChanged: (value) => _onTextFieldChanged(
                value,
                (v) =>
                    ref.read(sessionProvider.notifier).updateOrganizationInfo(
                          location: v,
                        ),
              ),
            ),

            const SizedBox(height: 24),

            // Framework grid - watches frameworks
            FrameworkGrid(
              isDesktop: isDesktop,
              gridColumns: gridColumns,
              childAspectRatio: childAspectRatio,
            ),
          ],
        ),
      ),
    );
  }
}
