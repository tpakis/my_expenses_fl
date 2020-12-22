import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String _buttonText;
  final Function _onClick;

  const AdaptiveFlatButton(this._buttonText, this._onClick);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        // ios button have opacity instead of ripple effect
        ? CupertinoButton(
            onPressed: _onClick,
            child: Text(
              _buttonText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : FlatButton(
            onPressed: _onClick,
            textColor: Theme.of(context).primaryColor,
            child: Text(
              _buttonText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
