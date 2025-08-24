// lib/widgets/spider_chart.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:maturity_model/models/framework_type.dart' show FrameworkType;

/// Data point for spider chart
class SpiderChartDataPoint {
  final String label;
  final double value;
  final double maxValue;

  const SpiderChartDataPoint({
    required this.label,
    required this.value,
    this.maxValue = 5.0,
  });

  /// Get normalized value (0.0 to 1.0)
  double get normalizedValue => value / maxValue;
}

/// Spider/Radar chart widget
class SpiderChart extends StatelessWidget {
  final List<SpiderChartDataPoint> dataPoints;
  final Color fillColor;
  final Color strokeColor;
  final Color gridColor;
  final Color labelColor;
  final double size;
  final bool showValues;
  final String? title;

  const SpiderChart({
    super.key,
    required this.dataPoints,
    this.fillColor = const Color(0x4CAF50FF),
    this.strokeColor = const Color(0xFF4CAF50),
    this.gridColor = const Color(0xFFE0E0E0),
    this.labelColor = const Color(0xFF424242),
    this.size = 300,
    this.showValues = true,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
        ],
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _SpiderChartPainter(
              dataPoints: dataPoints,
              fillColor: fillColor,
              strokeColor: strokeColor,
              gridColor: gridColor,
              labelColor: labelColor,
              showValues: showValues,
            ),
          ),
        ),
      ],
    );
  }
}

class _SpiderChartPainter extends CustomPainter {
  final List<SpiderChartDataPoint> dataPoints;
  final Color fillColor;
  final Color strokeColor;
  final Color gridColor;
  final Color labelColor;
  final bool showValues;

  _SpiderChartPainter({
    required this.dataPoints,
    required this.fillColor,
    required this.strokeColor,
    required this.gridColor,
    required this.labelColor,
    required this.showValues,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius =
        math.min(size.width, size.height) / 2 - 60; // Padding for labels
    final numberOfPoints = dataPoints.length;
    final angleStep = 2 * math.pi / numberOfPoints;

    // Draw grid/background
    _drawGrid(canvas, center, radius, numberOfPoints, angleStep);

    // Draw data shape
    _drawDataShape(canvas, center, radius, angleStep);

    // Draw labels
    _drawLabels(canvas, center, radius + 30, angleStep);
  }

  void _drawGrid(Canvas canvas, Offset center, double radius,
      int numberOfPoints, double angleStep) {
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw concentric circles (grid levels)
    for (int i = 1; i <= 5; i++) {
      final levelRadius = radius * (i / 5);
      canvas.drawCircle(center, levelRadius, gridPaint);
    }

    // Draw radial lines
    for (int i = 0; i < numberOfPoints; i++) {
      final angle = i * angleStep - math.pi / 2; // Start from top
      final endPoint = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(center, endPoint, gridPaint);
    }
  }

  void _drawDataShape(
      Canvas canvas, Offset center, double radius, double angleStep) {
    if (dataPoints.isEmpty) return;

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final points = <Offset>[];

    // Calculate data points
    for (int i = 0; i < dataPoints.length; i++) {
      final angle = i * angleStep - math.pi / 2; // Start from top
      final normalizedValue = dataPoints[i].normalizedValue.clamp(0.0, 1.0);
      final pointRadius = radius * normalizedValue;

      final point = Offset(
        center.dx + pointRadius * math.cos(angle),
        center.dy + pointRadius * math.sin(angle),
      );
      points.add(point);

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();

    // Draw filled shape
    canvas.drawPath(path, fillPaint);

    // Draw stroke
    canvas.drawPath(path, strokePaint);

    // Draw data points
    final pointPaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.fill;

    for (final point in points) {
      canvas.drawCircle(point, 4, pointPaint);
    }
  }

  void _drawLabels(
      Canvas canvas, Offset center, double labelRadius, double angleStep) {
    for (int i = 0; i < dataPoints.length; i++) {
      final angle = i * angleStep - math.pi / 2; // Start from top
      final labelPoint = Offset(
        center.dx + labelRadius * math.cos(angle),
        center.dy + labelRadius * math.sin(angle),
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: dataPoints[i].label,
          style: TextStyle(
            color: labelColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Adjust label position to center it around the point
      final labelOffset = Offset(
        labelPoint.dx - textPainter.width / 2,
        labelPoint.dy - textPainter.height / 2,
      );

      textPainter.paint(canvas, labelOffset);

      // Draw value if enabled
      if (showValues) {
        final valueText = dataPoints[i].value.toStringAsFixed(1);
        final valuePainter = TextPainter(
          text: TextSpan(
            text: valueText,
            style: TextStyle(
              color: labelColor.withValues(alpha: 0.7),
              fontSize: 10,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        valuePainter.layout();

        final valueOffset = Offset(
          labelPoint.dx - valuePainter.width / 2,
          labelPoint.dy + textPainter.height / 2 + 2,
        );

        valuePainter.paint(canvas, valueOffset);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

/// Spider chart configuration for different framework types
class SpiderChartConfig {
  /// Get spider chart data points for a given framework type
  static List<SpiderChartDataPoint> getDataPointsForFramework(
    FrameworkType frameworkType,
    Map<String, double> domainScores,
  ) {
    switch (frameworkType) {
      case FrameworkType.bpmn:
        return _getBpmnDataPoints(domainScores);
      case FrameworkType.adb:
        return _getAdbDataPoints(domainScores);
      case FrameworkType.eccmFacility:
      case FrameworkType.eccmOrganization:
        return _getEccmDataPoints(domainScores);
      case FrameworkType.is4hInstitutional:
      case FrameworkType.is4hCountry:
        return _getIs4hDataPoints(domainScores);
    }
  }

  static List<SpiderChartDataPoint> _getBpmnDataPoints(
      Map<String, double> domainScores) {
    final domains = [
      'Institutional Standards/Guidelines/Policies',
      'Stakeholder Management',
      'Adoption Processes',
      'Privacy Security Confidentiality',
      'Skills and Expertise',
      'Knowledge Assets Tools and Automation',
      'Goals and Measurement'
    ];

    return domains
        .map((domain) => SpiderChartDataPoint(
              label: _truncateLabel(domain),
              value: domainScores[domain] ?? 0.0,
              maxValue: 5.0,
            ))
        .toList();
  }

  static List<SpiderChartDataPoint> _getAdbDataPoints(
      Map<String, double> domainScores) {
    final domains = [
      'Core Readiness',
      'Technological Readiness',
      'Learning Readiness',
      'Societal Readiness'
    ];

    return domains
        .map((domain) => SpiderChartDataPoint(
              label: domain,
              value: domainScores[domain] ?? 0.0,
              maxValue: 5.0,
            ))
        .toList();
  }

  static List<SpiderChartDataPoint> _getEccmDataPoints(
      Map<String, double> domainScores) {
    final domains = [
      'Governance & Leadership',
      'Technology',
      'Interoperability',
      'Patient Centeredness',
      'Management of Technical Resources',
      'HIT Services and Functions',
      'Data Ownership and Data Quality',
      'Analytics and Business Intelligence',
      'HIT Learning Health System'
    ];

    return domains
        .map((domain) => SpiderChartDataPoint(
              label: _truncateLabel(domain),
              value: domainScores[domain] ?? 0.0,
              maxValue: 5.0,
            ))
        .toList();
  }

  static List<SpiderChartDataPoint> _getIs4hDataPoints(
      Map<String, double> domainScores) {
    final domains = [
      'Data Management and Information Technology',
      'Management and Governance',
      'Knowledge Management and Sharing',
      'Innovation'
    ];

    return domains
        .map((domain) => SpiderChartDataPoint(
              label: _truncateLabel(domain),
              value: domainScores[domain] ?? 0.0,
              maxValue: 5.0,
            ))
        .toList();
  }

  /// Truncate long labels to fit better on the chart
  static String _truncateLabel(String label) {
    if (label.length <= 20) return label;
    return '${label.substring(0, 17)}...';
  }
}
