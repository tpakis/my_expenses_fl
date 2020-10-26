import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  Function(String, double) addTransactionCallback;
  String _titleInput;
//  String _amountInput;
  final _amountController = TextEditingController();

  NewTransaction(this.addTransactionCallback);

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
              onChanged: (title) => {_titleInput = title},
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountController,
            ),
            FlatButton(
              onPressed: () {
                addTransactionCallback(
                    _titleInput, double.parse(_amountController.text)
                );
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
