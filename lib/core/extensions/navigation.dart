import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  pushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }
}
