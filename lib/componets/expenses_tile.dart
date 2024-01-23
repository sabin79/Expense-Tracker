import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime datetime;
  void Function(BuildContext)? deleteTapped;
  ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.datetime,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.red.shade400,
          ),
        ],
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text('${datetime.day}/${datetime.month}/${datetime.year}'),
        trailing: Text('\$$amount'),
      ),
    );
  }
}
