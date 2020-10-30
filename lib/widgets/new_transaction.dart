import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  Function(String, double) addTransactionCallback;

  NewTransaction(this.addTransactionCallback);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _amountController = TextEditingController();

  final _titleController = TextEditingController();

  void _submitData() {
    double amount = double.tryParse(_amountController.text);

    if (_titleController.text.isEmpty || amount == null) {
      return;
    }
    widget.addTransactionCallback(_titleController.text, amount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
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
            FlatButton(
              onPressed: () {
                _submitData();
              },
              child: Text("Add Transaction"),
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
