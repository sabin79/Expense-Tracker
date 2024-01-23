import 'package:expense_tracker/bar%20graph/bar_graph.dart';
import 'package:expense_tracker/daytime/day_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/expense_data.dart';

class ExpenseSummery extends StatelessWidget {
  final DateTime StartOfWeek;

  const ExpenseSummery({super.key, required this.StartOfWeek});

  @override
  Widget build(BuildContext context) {
    String sunday =
        convertDateTimeToString(StartOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(StartOfWeek.add(const Duration(days: 1)));

    String tuesday =
        convertDateTimeToString(StartOfWeek.add(const Duration(days: 2)));

    String wednesday =
        convertDateTimeToString(StartOfWeek.add(const Duration(days: 3)));
    String thrusday =
        convertDateTimeToString(StartOfWeek.add(const Duration(days: 4)));

    String friday =
        convertDateTimeToString(StartOfWeek.add(const Duration(days: 5)));

    String saturday =
        convertDateTimeToString(StartOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
        builder: (context, value, child) => SizedBox(
              height: 200,
              child: MyBarGraph(
                maxY: 100,
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
