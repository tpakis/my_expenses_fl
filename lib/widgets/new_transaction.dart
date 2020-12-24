import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/AdaptiveFlatButton.dart';

class NewTransaction extends StatefulWidget {
  Function(String, double, DateTime) addTransactionCallback;

  NewTransaction(this.addTransactionCallback) {
    print("Consrtuctor New transaction widget");
  }

  @override
  _NewTransactionState createState() {
    print("createState new transaction widget");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> with WidgetsBindingObserver {
  final _amountController = TextEditingController();

  final _titleController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print("constructor new transaction state");
  }

  // use it as onStart() to initialize net calls, db calls
  @override
  void initState() {
    print("initState new transaction state");
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  // not very useful, maybe refetch some data with new id from new widget?
  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    bool updated =
        widget != oldWidget; // we have access to the widget from state!
    print("didUpdateWidget: $updated , new transaction widget");
    super.didUpdateWidget(oldWidget);
  }

  // use it as onDestroy() cleanup listeners, observables
  @override
  void dispose() {
    print("dispose() dispose new transaction widget");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _submitData() {
    double amount = double.tryParse(_amountController.text);

    if (_titleController.text.isEmpty ||
        amount == null ||
        _selectedDate == null) {
      return;
    }
    widget.addTransactionCallback(_titleController.text, amount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      // future
      // user hit cancel
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Title"),
                controller: _titleController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) {
                  _submitData();
                },
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      // take all the available space
                      child: Text(
                        _selectedDate == null
                            ? "No Date Chosen!"
                            : "Picked Date ${DateFormat.yMd().format(_selectedDate)}",
                      ),
                    ),
                    AdaptiveFlatButton("Choose Date", _presentDatePicker)
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _submitData();
                },
                child: const Text("Add Transaction"),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
