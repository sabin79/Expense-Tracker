import 'package:expense_tracker/data/expense_data.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/expense_item.dart';

class HiveDataBase {
  // refrence out box
  final _myBox = Hive.box('expenses_database');

  // writing data
  void SaveData(List<ExpenseItem> allExpense) {
    /*


    hive can only store string and datetime , not not costume boject like Expenseitem
    so lets cnver Expenseitem objects into types that can be stored in our badatabse
    
    allExpense = 
    [
      ExpenseItem (name  / amount / dateTme)
      ..
    ]
    -> 
    [
      [
        name, amount , dataTIme
      ]
    ]
    */
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      //convert each expenseItems into a list of sotreable types (string, DateTime)
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      allExpensesFormatted.add(expenseFormatted);
    }
    _myBox.put("All Expenses", allExpensesFormatted);
  }

  // reading data
  List<ExpenseItem> readData() {
    /*
    data is stored in Hive as a list of String _ datetime 
    so ;et coner out saved data int  Expenseitem objects

    save data = [
      [name, amount, dateTime]
    ]

    -> 

    [
ExpenseItem ( name / amount / dateTime)
    ]
    */
    List saveExpense = _myBox.get("All Expenses") ?? [];
    List<ExpenseItem> allExpense = [];

    for (var i = 0; i < saveExpense.length; i++) {
      // colect individual expense data
      String name = saveExpense[i][0];
      String amount = saveExpense[i][1];
      DateTime dateTime = saveExpense[i][2];
      // create expense item
      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      // add espense to overall list of expense
      allExpense.add(expense);
    }
    return allExpense;
  }
}
