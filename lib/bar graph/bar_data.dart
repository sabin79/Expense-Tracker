import 'package:expense_tracker/bar%20graph/indvidual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thrAmount;
  final double friAMount;

  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thrAmount,
    required this.friAMount,
    required this.satAmount,
  });

  List<IndividualBar> barData = [];
  // intialize dar data
  void initializebarData() {
    barData = [
      IndividualBar(x: 0, y: sunAmount),
      IndividualBar(x: 1, y: monAmount),
      IndividualBar(x: 2, y: tueAmount),
      IndividualBar(x: 3, y: wedAmount),
      IndividualBar(x: 4, y: thrAmount),
      IndividualBar(x: 5, y: friAMount),
      IndividualBar(x: 6, y: satAmount),
    ];
  }
}
