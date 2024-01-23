import 'package:expense_tracker/componets/expense_summery.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../componets/expenses_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  // add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add new expense"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //expense name
              TextField(
                controller: newExpenseNameController,
              ),
              // expense amount
              TextField(
                controller: newExpenseAmountController,
              ),
            ],
          ),
          // save button
          actions: [
            MaterialButton(
              onPressed: save,
              child: const Text("Save"),
            ),
            //cancel button
            MaterialButton(
              onPressed: cancel,
              child: const Text("Cancel"),
            )
          ],
        );
      },
    );
  }

  // save
  void save() {
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addnewExpense(newExpense);

    Navigator.pop(context);
    clear();
  }

  // cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(builder: (context, value, child) {
      return Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
              onPressed: addNewExpense, child: const Icon(Icons.add)),
          body: ListView(
            children: [
              // weekly summery
              ExpenseSummery(StartOfWeek: value.startOFWeekDate()),
              // expenses list
              ListView.builder(
                  itemCount: value.getAllExpenselist().length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ExpenseTile(
                      name: value.overallExpenseList[index].name,
                      amount: value.getAllExpenselist()[index].amount,
                      datetime: value.getAllExpenselist()[index].dateTime,
                    );
                  }),
            ],
          ));
    });
  }
}
