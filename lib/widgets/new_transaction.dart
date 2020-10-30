import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  Function(String, double) addTransactionCallback;

  final _amountController = TextEditingController();
  final _titleController = TextEditingController();

  NewTransaction(this.addTransactionCallback);

  void _submitData() {
    double amount = double.tryParse(_amountController.text);

    if (_titleController.text.isEmpty || amount == null) {
      return;
    }
    addTransactionCallback(_titleController.text, amount);
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
