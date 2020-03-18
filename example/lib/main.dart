import 'dart:convert';

import 'package:features/features.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _counterFeature = Feature('counter'); //..defaultValue(false)

  SharedPreferences _prefs;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      _restoreFromCache();
    });
    super.initState();
  }

  void _restoreFromCache() {
    final _savedCache = _prefs.getString('cache');
    final Map<String, dynamic> _cache = json.decode(_savedCache);
    _counterFeature.enabled = _cache[_counterFeature.key];
  }

  void _saveToCache() {
    final _cache = <String, dynamic>{};
    _cache[_counterFeature.key] = _counterFeature.enabled;
    _prefs.setString('cache', json.encode(_cache));
  }

  void _incrementCounter() {
    if (mounted)
      setState(() {
        _counter++;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Container(
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              FeatureBuilder(
                feature: _counterFeature,
                builder: (context, enabled, child) => SwitchListTile(
                  title: Text('Enable Counter'),
                  value: enabled,
                  onChanged: (val) {
                    _counterFeature.enabled = val;
                    _saveToCache();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FeatureBuilder(
        feature: _counterFeature,
        hideOnInactive: true,
        builder: (context, enabled, child) => FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
