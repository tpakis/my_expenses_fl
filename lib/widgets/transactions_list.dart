import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses_fl/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionsList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _transactions.isEmpty
          ? Column(
              children: [
                Text(
                  "No transactions added!",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, itemIndex) {
                final transaction = _transactions[itemIndex];

                return Card(
                    child: Row(
                  children: [
                    Container(
                      // left right, top bottom symmetric
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      //for all directions
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "\$${transaction.amount.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transaction.title,
                            style: Theme.of(context).textTheme.title),
                        Text(
                          // DateFormat('yyyy-MM-dd').format(transaction.date),
                          DateFormat.yMMMd().format(transaction.date),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ));
              },
            ),
    );
  }
}
