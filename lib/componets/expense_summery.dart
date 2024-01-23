import 'package:expense_tracker/bar%20graph/bar_graph.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/expense_data.dart';

class ExpenseSummery extends StatelessWidget {
  final DateTime StartOfWeek;

  const ExpenseSummery({super.key, required this.StartOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context, value, child) => const SizedBox(
              height: 200,
              child: MyBarGraph(
                  maxY: 100,
                  sunAmount: 30,
                  monAmount: 40,
                  tueAmount: 10,
                  wedAmount: 70,
                  thrAmount: 50,
                  friAMount: 80,
                  satAmount: 8),
            ));
  }
}
