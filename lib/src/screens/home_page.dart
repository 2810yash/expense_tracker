import 'package:expence_tracker/src/components/expense_summary.dart';
import 'package:expence_tracker/src/components/expense_title.dart';
import 'package:expence_tracker/src/data/expense_data.dart';
import 'package:expence_tracker/src/models/edit_expense.dart';
import 'package:expence_tracker/src/models/expense_item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//txt controller
final newExpenseNameController = TextEditingController();
final newExpenseAmountController = TextEditingController();
final dataBaseRef = FirebaseDatabase.instance.ref("Expense Summary");

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).preparData();
  }

  //add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //expense Name
            TextField(
              controller: newExpenseNameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Expense Name'),
            ),

            //expense amount
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount Spent'),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: const Text('Save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  //delete
  void deleteExpense(ExpenseItem expense) {
    // from HIve
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
    // from Firebase
    String inputDate = expense.dateTime.toString();
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat('dd-MM-yyyy | hh:mm:ss a').format(dateTime);
    dataBaseRef.child(formattedDate).remove();
  }

  void deleteAll() {
    // from HIve
    Provider.of<ExpenseData>(context, listen: false).deleteAllExpense();
    // Form FireBAse
    dataBaseRef.remove();
  }

  //Edit
  void editExpense(ExpenseItem expense) {
    showDialog(
      context: context,
      builder: (context) => EditExpense(
        expense: expense,
        onSave: saveEditedExpense,
        context: context,
      ),
    );
  }

  void saveEditedExpense(ExpenseItem editedExpense) {
    // Save the edited expense in Hive
    Provider.of<ExpenseData>(context, listen: false).editExpense(editedExpense);

    String inputDate = editedExpense.dateTime.toString();
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat('dd-MM-yyyy | hh:mm:ss a').format(dateTime);
    // Save the edited expense in Firebase
    dataBaseRef.child(formattedDate).set({
      'Expense Amount': editedExpense.amount.toString(),
      'Expense Name': editedExpense.name.toString(),
    });
    Navigator.pop(context);
  }

  //save
  void save() {
    // save only if all field are filled
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      // create expense item
      // ****************  Hive Storage  ******************
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dateTime: DateTime.now(),
      );
      // add new expense
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);

      // ******************* FirebaseDatabase *********************
      String formattedDateTime =
          DateFormat('dd-MM-yyyy | hh:mm:ss a').format(DateTime.now());
      dataBaseRef.child(formattedDateTime).set({
        'Expense Name': newExpenseNameController.text.toString(),
        'Expense Amount': newExpenseAmountController.text.toString(),
      });
    }
    Navigator.pop(context);
    clear();
  }

  //cancel
  void cancel() {
    Navigator.pop(context);
  }

  // clear controller
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.blue,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: addNewExpense,
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Details()));
              },
              child: const Icon(Icons.abc),
            ),
          ],
        ),
        body: ListView(
          children: [
            //weekly summary
            ExpenseSummary(
                startOfWeek: value.startOfWeekDate(),
                firstWeek: DateTime.now()),

            const SizedBox(height: 30.0),

            //expense list By Hive Database
            Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color.fromRGBO(178, 219, 244, 1.0),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenseList()[index].name,
                  amount: value.getAllExpenseList()[index].amount,
                  dateTime: value.getAllExpenseList()[index].dateTime,
                  deleteTapped: (p0) =>
                      deleteExpense(value.getAllExpenseList()[index]),
                  editTapped: (p0) =>
                      editExpense(value.getAllExpenseList()[index]),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
              child: Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    child: OutlinedButton(
                      onPressed: () => deleteAll(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.delete, color: Colors.red[300]),
                          Text('Delete All', style: TextStyle(color: Colors.red[300])),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
