import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension MediaQueryExt on MediaQueryData {

  double availableHeight(PreferredSizeWidget appBar) {
    return this.size.height -
        appBar.preferredSize.height -
        this.padding.top;
  }

  bool isLandscape() {
    return this.orientation == Orientation.landscape;
  }

  bool isPortrait() {
    return this.orientation == Orientation.portrait;
  }

}
