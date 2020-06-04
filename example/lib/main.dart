import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:platform_interface/platform_interface.dart';

void main() => runApp(MyApp());

/// Demo getting a device locale
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List _languages = List();
  Locale _locale;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    List languages;
    Locale currentLocale;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      languages = await PlatformInterface.locale.preferredLanguages;
      print(languages);
    } on PlatformException {
      print("Error obtaining preferred languages");
    }
    try {
      currentLocale = await PlatformInterface.locale.currentLocale;
      print(currentLocale);
    } on PlatformException {
      print("Error obtaining current locale");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _languages = languages;
      _locale = currentLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Text("Current locale: "),
            Text('$_locale'),
            Text("Preferred Languages: "),
            Text(_languages.toString()),
            Padding(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                  onPressed: () {
                    listLanguages();
                  },
                  child: Text("Run Test")),
            ),
          ],
        )),
      ),
    );
  }

  /// testing for issue-12
  void listLanguages() async {
    List languages = await PlatformInterface.locale.preferredLanguages;
    Locale locale = await PlatformInterface.locale.currentLocale;
    print('current locale: $locale, preferred device languages:');
    languages.forEach((l) => print(l));
  }
}
