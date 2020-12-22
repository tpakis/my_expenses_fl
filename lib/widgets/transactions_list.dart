import 'package:flutter/material.dart';
import '../widgets/transaction_item.dart';
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

              return TransactionItem(
                  transaction: transaction,
                  deleteTransaction: _deleteTransaction);
            },
          );
  }
}
