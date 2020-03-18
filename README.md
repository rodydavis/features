# features

A Flutter package to help with scoping features for a project.

Online Demo: https://rodydavis.github.io/features/

## Getting Started

Create a feature:

```dart
Feature _feature = Feature('counter');
```

Enable/Disable a feature:

```dart
Feature _feature.enabled = false;
Feature _feature.enabled = true;
```

Use a feature builder to react to changes:

```dart
floatingActionButton: FeatureBuilder(
    feature: _counterFeature,
    hideOnInactive: true,
    builder: (context, enabled, child) => FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
),
),
```

Use a feature provider:

```dart

Features(
    items: <Feature>[],
    child: Container(),
)

final _features = Features.of(context);

```