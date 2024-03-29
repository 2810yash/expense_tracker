import 'package:expence_tracker/src/data/hive_database.dart';
import 'package:expence_tracker/src/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import '../models/expense_item.dart';

class ExpenseData extends ChangeNotifier{
  //List of all Expenses
  List<ExpenseItem> overallExpenseList = [];

  //get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  //display
  final db= HiveDataBase();
  void preparData(){
    if(db.readData().isNotEmpty){
      overallExpenseList = db.readData();
    }
  }

  //Add new expenses
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // Edit Expense
  void editExpense(ExpenseItem editedExpense) {
    // Find the index of the edited expense in your list
    final int index = overallExpenseList.indexWhere(
          (expense) => expense.dateTime == editedExpense.dateTime,
    );

    if (index != -1) {
      // Replace the old expense with the edited one
      overallExpenseList[index] = editedExpense;

      notifyListeners();
      db.saveData(overallExpenseList);
    }
  }

  //Dalete Expenses
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }
  void deleteAllExpense() {
    overallExpenseList.clear();

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //get weekdays
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fir';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  //get the date for the start of the week(Sunday)
  DateTime startOfWeekDate(){
    DateTime? startOfWeek;

    //get todays date&time
    DateTime today = DateTime.now();

    //going backwards from today to find nearest sunday
    for(int i=0;i<7;i++){
      if(getDayName(today.subtract(Duration(days: i))) == 'Sun'){
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

  /*
    convert overall list of expenses into a daily expenses summary
  */

  Map<String, double> calculateDailyExpenseSummary(){
    Map<String, double> dailyExpenseSummary = {
      // date(yyyymmdd) : amountTotalForDay
    };

    for (var expense in overallExpenseList){
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if(dailyExpenseSummary.containsKey(date)){
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else{
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }
}
