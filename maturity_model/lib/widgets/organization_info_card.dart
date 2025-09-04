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
        Center,
        BorderRadius;

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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseSpacing = textTheme.bodyMedium!.fontSize!;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: isDesktop ? baseSpacing * 50 : double.infinity),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(baseSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Organization Information',
                  style: textTheme.titleLarge,
                ),
                SizedBox(height: baseSpacing),

                // Use row layout for desktop, column for mobile
                if (isDesktop || isTablet)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: orgController,
                          decoration: InputDecoration(
                            labelText: 'Organization',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(baseSpacing * 0.5),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: baseSpacing * 0.75,
                              vertical: baseSpacing * 0.75,
                            ),
                          ),
                          style: textTheme.bodyLarge,
                          onChanged: onOrgChanged,
                        ),
                      ),
                      SizedBox(width: baseSpacing * 0.75),
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Assessor',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(baseSpacing * 0.5),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: baseSpacing * 0.75,
                              vertical: baseSpacing * 0.75,
                            ),
                          ),
                          style: textTheme.bodyLarge,
                          onChanged: onNameChanged,
                        ),
                      ),
                      SizedBox(width: baseSpacing * 0.75),
                      Expanded(
                        child: TextField(
                          controller: locationController,
                          decoration: InputDecoration(
                            labelText: 'Location',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(baseSpacing * 0.5),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: baseSpacing * 0.75,
                              vertical: baseSpacing * 0.75,
                            ),
                          ),
                          style: textTheme.bodyLarge,
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
                        decoration: InputDecoration(
                          labelText: 'Organization Name',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(baseSpacing * 0.5),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: baseSpacing * 0.75,
                            vertical: baseSpacing * 0.75,
                          ),
                        ),
                        style: textTheme.bodyLarge,
                        onChanged: onOrgChanged,
                      ),
                      SizedBox(height: baseSpacing * 0.75),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Assessor Name',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(baseSpacing * 0.5),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: baseSpacing * 0.75,
                            vertical: baseSpacing * 0.75,
                          ),
                        ),
                        style: textTheme.bodyLarge,
                        onChanged: onNameChanged,
                      ),
                      SizedBox(height: baseSpacing * 0.75),
                      TextField(
                        controller: locationController,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(baseSpacing * 0.5),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: baseSpacing * 0.75,
                            vertical: baseSpacing * 0.75,
                          ),
                        ),
                        style: textTheme.bodyLarge,
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
