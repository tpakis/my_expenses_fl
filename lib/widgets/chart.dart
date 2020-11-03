import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  static const _emptyList = <Transaction>[];

  Chart([this.recentTransactions = _emptyList]);

  List<Map<String, Object>> get groupedTransactionValues {
    final totalAmount = getTotalAmountInTransactionsList(recentTransactions);

    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      final weekDayTransactions = recentTransactions.takeWhile((value) {
        return value.date.day == weekDay.day &&
            value.date.month == weekDay.month &&
            value.date.year == weekDay.year;
      });

      return {
        "day": DateFormat.E(weekDay),
        "amount": getTotalAmountInTransactionsList(weekDayTransactions)
      };
    });
  }

  double getTotalAmountInTransactionsList(
      final List<Transaction> transactions) {
    var totalAmount = 0.0;

    transactions.forEach((element) {
      totalAmount += element.amount;
    });
    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [],
      ),
    );
  }
}
