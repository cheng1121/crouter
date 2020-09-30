library app_base;

import 'package:flutter/material.dart';
import 'package:crouter/crouter.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

@CRouter('app_base/base')
class BasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

@CRouter('app_base/splash')
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
