import 'package:hive/hive.dart';
import '../models/expense_item.dart';

class HiveDataBase {
  // reference our box
  final _myBox = Hive.box("expense_database");

  // write data
  void saveData(List<ExpenseItem> allExpense) {
    /*
    * Hive can only store String and datetime,
    * Not stores custom objects like ExpenseItem
    */
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      // convert each expenseItem into a list of storeable type
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    // now can store in database
    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  // read data
  List<ExpenseItem> readData() {
    List saveExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < saveExpenses.length; i++) {
      String name = saveExpenses[i][0];
      String amount = saveExpenses[i][1];
      DateTime dateTime = saveExpenses[i][2];

      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      // add expense to overall list of expense
      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
