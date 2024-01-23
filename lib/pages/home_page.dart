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
  final newExpensedollarController = TextEditingController();
  final newExpensecentsController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // prepare data
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

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
                decoration: const InputDecoration(
                  hintText: "Expense name",
                ),
              ),
              // expense amount
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: newExpensedollarController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "dollars",
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: newExpensecentsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Cents",
                      ),
                    ),
                  )
                ],
              )
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
    // put dollars and cents together and convert to double
    String amount =
        '${newExpensedollarController.text}.${newExpensecentsController.text}';
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: amount,
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
    newExpensedollarController.clear();
    newExpensecentsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(builder: (context, value, child) {
      return Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: ListView(
            children: [
              // weekly summery
              ExpenseSummery(StartOfWeek: value.startOFWeekDate()),
              const SizedBox(
                height: 20,
              ),
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
