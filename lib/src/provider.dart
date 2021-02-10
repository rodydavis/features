import 'package:flutter/material.dart';

import 'feature.dart';

class Features extends InheritedWidget {
  const Features({
    Key? key,
    required this.items,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Feature> items;

  static Features? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Features>();
  }

  @override
  bool updateShouldNotify(Features old) => items != old.items;
}
