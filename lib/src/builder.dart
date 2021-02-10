import 'package:flutter/material.dart';

import 'feature.dart';
import 'provider.dart';

class FeatureBuilder extends StatelessWidget {
  final String? featureKey;
  final Feature? feature;
  final Widget? child;
  final Widget Function(BuildContext, bool, Widget?) builder;
  final bool hideOnInactive;

  const FeatureBuilder({
    Key? key,
    required this.builder,
    this.featureKey,
    this.child,
    this.feature,
    this.hideOnInactive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _features = Features.of(context);
    final _feature = feature ??
        _features?.items.firstWhere((element) => element.key == featureKey);
    if (_feature == null) {
      return Visibility(
        visible: hideOnInactive ? false : true,
        child: builder(context, false, child),
      );
    }
    return ValueListenableBuilder<bool>(
      valueListenable: _feature.isActive,
      builder: (context, active, child) {
        return Visibility(
          visible: hideOnInactive ? active : true,
          child: builder(context, active, child),
        );
      },
      child: child,
    );
  }
}
