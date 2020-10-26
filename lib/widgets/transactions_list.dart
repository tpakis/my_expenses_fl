import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses_fl/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionsList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _transactions.map((transaction) {
        return Card(
            child: Row(
              children: [
                Container(
                  // left right, top bottom symmetric
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 2,
                    ),
                  ),
                  //for all directions
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "\$${transaction.amount}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      // DateFormat('yyyy-MM-dd').format(transaction.date),
                      DateFormat.yMMMd().format(transaction.date),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                )
              ],
            ));
      }).toList(),
    );
  }
}
