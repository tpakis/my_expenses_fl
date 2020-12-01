import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function(String, double, DateTime) addTransactionCallback;

  NewTransaction(this.addTransactionCallback);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _amountController = TextEditingController();

  final _titleController = TextEditingController();
  DateTime _selectedDate;

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
                decoration: InputDecoration(labelText: "Title"),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
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
                    FlatButton(
                      onPressed: () {
                        _presentDatePicker();
                      },
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        "Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _submitData();
                },
                child: Text("Add Transaction"),
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
