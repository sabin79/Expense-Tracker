import 'package:expense_tracker/bar%20graph/bar_graph.dart';
import 'package:expense_tracker/daytime/day_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/expense_data.dart';

class ExpenseSummery extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummery({
    super.key,
    required this.startOfWeek,
  });

  // calculate max amount in bar graph
  double calcumateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thrusday,
    String friday,
    String saturday,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummery()[sunday] ?? 0,
      value.calculateDailyExpenseSummery()[monday] ?? 0,
      value.calculateDailyExpenseSummery()[tuesday] ?? 0,
      value.calculateDailyExpenseSummery()[wednesday] ?? 0,
      value.calculateDailyExpenseSummery()[thrusday] ?? 0,
      value.calculateDailyExpenseSummery()[friday] ?? 0,
      value.calculateDailyExpenseSummery()[saturday] ?? 0,
    ];
    // sort from smallesr to largest
    values.sort();
    // get largest amount (whish is at the end pf the sorted list )
    // and increase the cap sloghtly  so the graph looks alomsut full
    max == values.last * 1.1;

    return max == 0 ? 100 : max;
  }

  @override
  Widget build(BuildContext context) {
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));

    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));

    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thrusday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));

    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));

    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
        builder: (context, value, child) => SizedBox(
              height: 200,
              child: MyBarGraph(
                maxY: calcumateMax(
                  value,
                  sunday,
                  monday,
                  tuesday,
                  wednesday,
                  thrusday,
                  friday,
                  saturday,
                ),
                sunAmount: value.calculateDailyExpenseSummery()[sunday] ?? 0,
                monAmount: value.calculateDailyExpenseSummery()[monday] ?? 0,
                tueAmount: value.calculateDailyExpenseSummery()[tuesday] ?? 0,
                wedAmount: value.calculateDailyExpenseSummery()[wednesday] ?? 0,
                thrAmount: value.calculateDailyExpenseSummery()[thrusday] ?? 0,
                friAMount: value.calculateDailyExpenseSummery()[friday] ?? 0,
                satAmount: value.calculateDailyExpenseSummery()[saturday] ?? 0,
              ),
            ));
  }
}
