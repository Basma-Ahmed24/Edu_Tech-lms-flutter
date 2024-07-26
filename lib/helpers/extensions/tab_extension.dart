import 'package:flutter/material.dart';

extension XTab on Widget {
  setOnTab({required void Function() onTab}) => InkWell(
    onTap: onTab,
    child: this,
  );
}