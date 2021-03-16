import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartBase extends StatelessWidget {
  final Widget rightWidget;
  final List<PieChartSectionData> sections;
  final double centerSpaceRadius;
  final double _radius;
  final double? height;
  final double? width;

  PieChartBase({
    Key? key,
    required this.rightWidget,
    required this.sections,
    this.centerSpaceRadius = 20,
    this.height = 130,
    this.width,
  })  : _radius = sections.first.radius,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? _containerHeight,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: height ?? _containerHeight,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: centerSpaceRadius,
                  sectionsSpace: 0,
                  startDegreeOffset: 0,
                  sections: sections,
                ),
              ),
            ),
          ),
          Expanded(
            child: rightWidget,
          ),
        ],
      ),
    );
  }

  double get _containerHeight {
    if (centerSpaceRadius == 0) {
      return _radius * 2;
    } else {
      return (_radius * 2) + (centerSpaceRadius);
    }
  }
}
