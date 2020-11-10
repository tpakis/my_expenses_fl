import 'package:flutter/material.dart';
import '../widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  static const _emptyList = <Transaction>[];

  Chart([this.recentTransactions = _emptyList]);

  double get _totalAmount {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item["amount"];
    });
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      final weekDayTransactions = recentTransactions.where((value) {
        return value.date.day == weekDay.day &&
            value.date.month == weekDay.month &&
            value.date.year == weekDay.year;
      }).toList();

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
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
        children: groupedTransactionValues.map((transactionsInDay) {
          return ChartBar(
            transactionsInDay["day"],
            transactionsInDay["amount"],
            (_totalAmount == 0.0) ? 0.0 : (transactionsInDay["amount"] as double) / _totalAmount,
          );
        }).toList(),
      ),
    );
  }
}
