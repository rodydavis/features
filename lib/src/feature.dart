import 'package:flutter/material.dart';

class Feature {
  @override
  final String key;

  final ValueNotifier<bool> isActive = ValueNotifier(false);

  Feature(this.key);

  bool get enabled => isActive.value;
  set enabled(bool value) {
    if (value != enabled) {
      isActive.value = value;
    }
  }

  void defaultValue(bool value) {
    enabled = value;
  }
}
