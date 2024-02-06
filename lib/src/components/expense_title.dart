import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;
  void Function(BuildContext)? editTapped;

  ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
    required this.editTapped,
  });

  @override
  Widget build(BuildContext context) {
    double total = 0;
    total += double.parse(amount);
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        //delete btn
        SlidableAction(
          onPressed: deleteTapped,
          icon: Icons.delete,
          backgroundColor: Colors.red,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              bottomLeft: Radius.circular(4.0),
            ),
        ),

        //Edit btn
        SlidableAction(
          onPressed: editTapped,
          icon: Icons.edit,
          backgroundColor: Colors.green,
        ),
      ]),
      child: ListTile(
        title: Text(name),
        subtitle:
            Text('${dateTime.day} / ${dateTime.month} / ${dateTime.year}'),
        trailing: Text('Rs.${total.toStringAsFixed(2)}'),
      ),
    );
  }
}
