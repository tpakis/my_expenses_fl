import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required Function deleteTransaction,
  }) : _deleteTransaction = deleteTransaction, super(key: key);

  final Transaction transaction;
  final Function _deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text("\$${transaction.amount}"),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
          textColor: Theme.of(context).errorColor,
          icon: const Icon(Icons.delete),
          label: const Text("Delete"),
          onPressed: () {
            _deleteTransaction(transaction.id);
          },
        )
            : IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () {
            _deleteTransaction(transaction.id);
          },
        ),
      ),
    );
  }
}