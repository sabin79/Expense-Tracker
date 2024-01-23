import 'package:expense_tracker/data/hive_database.dart';
import 'package:expense_tracker/daytime/day_time_helper.dart';
import 'package:flutter/material.dart';

import '../models/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  // list pf all expenses
  List<ExpenseItem> overallExpenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpenselist() {
    return overallExpenseList;
  }

// prepare data to display
  final db = HiveDataBase();

  void prepareData() {
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  // add new expense
  void addnewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
    db.SaveData(overallExpenseList);
  }

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.SaveData(overallExpenseList);
  }

  // get weekday for dateTime pbject
  String getDayName(DateTime time) {
    switch (time.weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  // get the date for the start of the week
  DateTime startOFWeekDate() {
    DateTime? startOfWeek;

    // get today date
    DateTime today = DateTime.now();

    //go backwards from today to find sunday
    for (var i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sunday') {
        startOfWeek = today.subtract(Duration(days: i));
        break;
      }
    }
    return startOfWeek!;
  }

  /* 
  convert overall  list of expenses into a daily expenses summery 


  e.g overallExpenseslist = [

    [foot, 2023/01/30, $101], 
    [food, 2023/01/30, $101], 
    [food, 2023/01/30, $101], 
    [food, 2023/01/30, $101], 
    [food, 2023/01/30, $101], 
    [food, 2023/01/30, $101], 
    [food, 2023/01/30, $101], 
    [food, 2023/01/30, $101], 
    [food, 2023/01/30, $101], 

  ]


  -> 
  daily expenseSummery = 
  [
    [2023/01/30: $25],
    [2023/01/30: $25],
    [2023/01/30: $25],
    [2023/01/30: $25],
    [2023/01/30: $25],
    [2023/01/30: $25],

  ]

  */

  Map<String, double> calculateDailyExpenseSummery() {
    Map<String, double> dailyExpenseSummery = {
      //day(yyyymmdd) : amount Totalforday
    };
    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);
      if (dailyExpenseSummery.containsKey(date)) {
        double currentAmount = dailyExpenseSummery[date]!;
        currentAmount += amount;
        dailyExpenseSummery[date] = currentAmount;
      } else {
        dailyExpenseSummery.addAll({date: amount});
      }
    }
    return dailyExpenseSummery;
  }
}
