import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    String expenseName = newExpenseNameController.text;
    String expenseAmountString = newExpenseAmountController.text;

    // Check if the expense amount is a valid double
    if (double.tryParse(expenseAmountString) != null) {
      double expenseAmount = double.parse(expenseAmountString);

      ExpenseItem newExpense = ExpenseItem(
        name: expenseName,
        amount: expenseAmount,
        dateTime: DateTime.now(),
      );
// add this new expense
      Provider.of<ExpenseData>(context, listen: false)
          .addnewExpense(newExpense);
    }
    clear();
  }

  // cancel
  void cancel() {
    clear();
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: ((context, value, child) => Scaffold(
            backgroundColor: Colors.grey[300],
            floatingActionButton: FloatingActionButton(
              onPressed: addNewExpense,
              child: const Icon(Icons.add),
            ),
            body: ListView.builder(
                itemCount: value.getAllExpenselist().length,
                itemBuilder: ((context, index) => ListTile(
                      title: Text(
                        value.getAllExpenselist()[index].name,
                      ),
                      subtitle: Text(
                          value.getAllExpenselist()[index].dateTime.toString()),
                      trailing:
                          Text("\$${value.getAllExpenselist()[index].amount}"),
                    ))),
          )),
    );
  }
}
