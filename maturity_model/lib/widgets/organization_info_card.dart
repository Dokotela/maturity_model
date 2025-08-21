// Separate widget for organization info - doesn't watch any providers
import 'package:flutter/material.dart'
    show
        StatelessWidget,
        TextEditingController,
        ValueChanged,
        BuildContext,
        Widget,
        EdgeInsets,
        SizedBox,
        InputDecoration,
        BoxConstraints,
        CrossAxisAlignment,
        Theme,
        Text,
        OutlineInputBorder,
        TextField,
        Expanded,
        Row,
        Column,
        Padding,
        Card,
        ConstrainedBox,
        Center;

class OrganizationInfoCard extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  final TextEditingController orgController;
  final TextEditingController nameController;
  final TextEditingController locationController;
  final ValueChanged<String> onOrgChanged;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onLocationChanged;

  const OrganizationInfoCard({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    required this.orgController,
    required this.nameController,
    required this.locationController,
    required this.onOrgChanged,
    required this.onNameChanged,
    required this.onLocationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: isDesktop ? 800 : double.infinity),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Organization Information',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),

                // Use row layout for desktop, column for mobile
                if (isDesktop || isTablet)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: orgController,
                          decoration: const InputDecoration(
                            labelText: 'Organization',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          onChanged: onOrgChanged,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Assessor',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          onChanged: onNameChanged,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: locationController,
                          decoration: const InputDecoration(
                            labelText: 'Location',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          onChanged: onLocationChanged,
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      TextField(
                        controller: orgController,
                        decoration: const InputDecoration(
                          labelText: 'Organization Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: onOrgChanged,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Assessor Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: onNameChanged,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: onLocationChanged,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
