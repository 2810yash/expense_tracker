import 'package:flutter/material.dart';
import 'expense_item.dart';

class EditExpense extends StatefulWidget {
  final BuildContext context;
  final ExpenseItem expense;
  final Function(ExpenseItem) onSave;

  const EditExpense({
    Key? key,
    required this.context,
    required this.expense,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditExpenseState createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
  final TextEditingController expenseNameController = TextEditingController();
  final TextEditingController expenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Pre-fill the controllers with the details of the expense being edited
    expenseNameController.text = widget.expense.name;
    expenseAmountController.text = widget.expense.amount;
  }

  void editExpense(ExpenseItem editedExpense) {
    // Notify the parent widget about the edited expense
    widget.onSave(editedExpense);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Expense"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Expense Name
          TextField(
            controller: expenseNameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(labelText: 'Expense Name'),
          ),

          // Expense Amount
          TextField(
            controller: expenseAmountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount Paid'),
          ),
        ],
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            // Save the edited expense
            editExpense(
              ExpenseItem(
                name: expenseNameController.text,
                amount: expenseAmountController.text,
                dateTime: widget.expense.dateTime,
              ),
            );
          },
          child: Text('Save'),
        ),
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
