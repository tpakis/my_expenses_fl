import 'package:flutter/material.dart';

double availableHeight(BuildContext context, AppBar appBar) {
  return MediaQuery.of(context).size.height -
      appBar.preferredSize.height -
      MediaQuery.of(context).padding.top;
}

bool isLandscape(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.landscape;
}

bool isPortrait(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}
