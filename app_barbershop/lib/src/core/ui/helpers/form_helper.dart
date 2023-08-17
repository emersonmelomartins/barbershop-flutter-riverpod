import 'package:flutter/material.dart';

void unfocus(BuildContext context) => FocusScope.of(context).unfocus();

extension Unfocus on BuildContext {
  void unfocus() => Focus.of(this).unfocus();
}
