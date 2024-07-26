import 'package:flutter/cupertino.dart';

extension XPad on Widget {
  padLRTB({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: this,
    );
  }

  padSym({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this,
    );
  }

  pad({
    double padding = 0,
  }) {
    return Padding(
      padding: EdgeInsets.all(
          padding
      ),
      child: this,
    );
  }
}