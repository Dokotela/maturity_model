// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maturity_model/maturity_model.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IS4H Maturity Assessment Tool',
      builder: (context, child) {
        // Calculate responsive multiplier based on screen size
        final mediaQuery = MediaQuery.of(context);
        final screenWidth = mediaQuery.size.width;

        // Define breakpoints and multipliers
        final double baseUnit = 16.0;
        final double screenMultiplier;

        if (screenWidth > 1200) {
          screenMultiplier = 2.0; // Desktop
        } else if (screenWidth > 600) {
          screenMultiplier = 1.5; // Tablet
        } else {
          screenMultiplier = 1.0; // Mobile
        }

        final scaledBase = baseUnit * screenMultiplier;

        // Create responsive theme based on calculated values
        final responsiveTheme = ThemeData(
          primarySwatch: Colors.teal,
          useMaterial3: true,

          textTheme: TextTheme(
            // Display styles - multiples of base
            displayLarge: TextStyle(
              fontSize: scaledBase * 3.0, // 48px mobile, 96px desktop
              fontWeight: FontWeight.bold,
            ),
            displayMedium: TextStyle(
              fontSize: scaledBase * 2.5, // 40px mobile, 80px desktop
              fontWeight: FontWeight.bold,
            ),
            displaySmall: TextStyle(
              fontSize: scaledBase * 2.25, // 36px mobile, 72px desktop
              fontWeight: FontWeight.bold,
            ),

            // Headlines - multiples of base
            headlineLarge: TextStyle(
              fontSize: scaledBase * 2.0, // 32px mobile, 64px desktop
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              fontSize: scaledBase * 1.75, // 28px mobile, 56px desktop
              fontWeight: FontWeight.bold,
            ),
            headlineSmall: TextStyle(
              fontSize: scaledBase * 1.5, // 24px mobile, 48px desktop
              fontWeight: FontWeight.bold,
            ),

            // Titles - multiples of base
            titleLarge: TextStyle(
              fontSize: scaledBase * 1.5, // 24px mobile, 48px desktop
              fontWeight: FontWeight.w600,
            ),
            titleMedium: TextStyle(
              fontSize: scaledBase * 1.25, // 20px mobile, 40px desktop
              fontWeight: FontWeight.w600,
            ),
            titleSmall: TextStyle(
              fontSize: scaledBase * 1.125, // 18px mobile, 36px desktop
              fontWeight: FontWeight.w600,
            ),

            // Body text - multiples of base
            bodyLarge: TextStyle(
              fontSize: scaledBase * 1.25, // 20px mobile, 40px desktop
              height: 1.5,
            ),
            bodyMedium: TextStyle(
              fontSize: scaledBase * 1.125, // 18px mobile, 36px desktop
              height: 1.5,
            ),
            bodySmall: TextStyle(
              fontSize: scaledBase * 1.0, // 16px mobile, 32px desktop
              height: 1.5,
            ),

            // Labels - multiples of base
            labelLarge: TextStyle(
              fontSize: scaledBase * 1.125, // 18px mobile, 36px desktop
              fontWeight: FontWeight.w500,
            ),
            labelMedium: TextStyle(
              fontSize: scaledBase * 1.0, // 16px mobile, 32px desktop
              fontWeight: FontWeight.w500,
            ),
            labelSmall: TextStyle(
              fontSize: scaledBase * 0.875, // 14px mobile, 28px desktop
              fontWeight: FontWeight.w500,
            ),
          ),

          // Input decoration theme - uses scaled values
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(fontSize: scaledBase * 1.125),
            hintStyle: TextStyle(fontSize: scaledBase * 1.125),
            helperStyle: TextStyle(fontSize: scaledBase * 1.0),
            errorStyle: TextStyle(fontSize: scaledBase * 0.875),
            contentPadding: EdgeInsets.symmetric(
              horizontal: scaledBase * 1.25,
              vertical: scaledBase * 1.25,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(scaledBase * 0.5),
            ),
          ),

          // Button themes - uses scaled values
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: scaledBase * 1.25,
                fontWeight: FontWeight.w600,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: scaledBase * 2.0,
                vertical: scaledBase * 1.25,
              ),
              minimumSize: Size(
                scaledBase * 6.25, // Min width
                scaledBase * 3.75, // Min height
              ),
            ),
          ),

          // AppBar theme - uses scaled values
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: scaledBase * 1.625,
              fontWeight: FontWeight.bold,
            ),
            toolbarHeight: scaledBase * 4.375,
            elevation: 2,
          ),

          // Card theme
          cardTheme: CardThemeData(
            elevation: 3,
            margin: EdgeInsets.all(scaledBase * 0.5),
          ),

          // Navigation bar theme - responsive
          navigationBarTheme: NavigationBarThemeData(
            height: scaledBase * 5.0,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            indicatorColor: Colors.teal.withValues(alpha: 0.1),
          ),
        );

        // Apply the responsive theme to the child
        return Theme(
          data: responsiveTheme,
          child: Builder(
            builder: (context) => child!,
          ),
        );
      },
      home: const MainNavigationScreen(),
    );
  }
}
