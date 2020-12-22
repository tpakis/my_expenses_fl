import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  const TransactionsList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  "No transactions added!",
                  style: Theme.of(context).textTheme.title,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (context, itemIndex) {
              final transaction = _transactions[itemIndex];

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
            },
          );
  }
}
