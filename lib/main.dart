import 'package:flutter/material.dart';
import 'package:my_expenses_fl/utils/Utils.dart';
import 'package:my_expenses_fl/widgets/chart.dart';
import './themes/AppTheme.dart';
import './models/transaction.dart';

import './widgets/new_transaction.dart';
import './widgets/transactions_list.dart';

// => curly braces can be replaced with => if only one statement...
void main() {
  /*// we need it for some devices to lock orientation to work
  WidgetsFlutterBinding.ensureInitialized();
  // lock orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter App', home: MyHomePage(), theme: appTheme);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    /* Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 16.53,
        date: DateTime.now())*/
  ];

  bool _showChart = false;

  void _addTransaction(String title, double amount, DateTime date) {
    final transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);

    setState(() {
      _transactions.add(transaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      title: Text('Flutter App'),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              startAddNewTransaction(context);
            }),
      ],
    );
    return Scaffold(
      appBar: _appBar,
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Show Chart"),
              Switch(
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  })
            ],
          ),
          _showChart
              ? Container(
                  height: availableHeight(context, _appBar) * 0.7,
                  child: Chart(_recentTransactions),
                )
              : Container(
                  height: availableHeight(context, _appBar) * 0.7,
                  child: TransactionsList(_transactions, _deleteTransaction),
                ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startAddNewTransaction(context);
        },
      ),
    );
  }
}
