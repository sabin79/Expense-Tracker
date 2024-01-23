import 'package:expense_tracker/bar%20graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thrAmount;
  final double friAMount;
  final double satAmount;
  const MyBarGraph(
      {super.key,
      required this.maxY,
      required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thrAmount,
      required this.friAMount,
      required this.satAmount});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: sunAmount,
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thrAmount: thrAmount,
      friAMount: friAMount,
      satAmount: satAmount,
    );
    myBarData.initializebarData();
    return BarChart(BarChartData(
      maxY: 100,
      minY: 0,
      barGroups: myBarData.barData
          .map((data) => BarChartGroupData(
              x: data.x, barRods: [BarChartRodData(toY: data.y)]))
          .toList(),
    ));
  }
}
