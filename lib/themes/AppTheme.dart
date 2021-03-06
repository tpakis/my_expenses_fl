import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final appBarTextStyle = TextStyle(
    fontFamily: "OpenSans", fontSize: 20);

final titleTextStyle = TextStyle(
    fontFamily: "OpenSans", fontWeight: FontWeight.bold, fontSize: 18);

const _defaultFont = "Quicksand";

final materialAppTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.amber,
  fontFamily: _defaultFont,
  textTheme: ThemeData.light().textTheme.copyWith(
        title: titleTextStyle,
        button: TextStyle(color: Colors.white)
      ),
  appBarTheme: AppBarTheme(
    textTheme: ThemeData.light().textTheme.copyWith(
          title: appBarTextStyle,
        ),
  ),
);

