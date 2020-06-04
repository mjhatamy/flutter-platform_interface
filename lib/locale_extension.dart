import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class PlatformLocale {
  MethodChannel _channel;
  PlatformLocale(MethodChannel channel) {
    this._channel = channel;
  }
  /// Returns a [String] of the currently set DEVICE locale made up of the language and the region
  /// (e.g. en-US or en_US)
  Future<Locale> get currentLocale async {
    final String currentLocaleString = await _channel.invokeMethod('currentLocale');
    Map<String, dynamic> currentLocaleJson = jsonDecode(currentLocaleString);
    if(currentLocaleJson != null) {
      return _localeFromJson(currentLocaleJson);
    }
    return null;
  }

  /// Returns a [List] of locales from the device
  /// the first in the list should be the current one set on the device
  /// for example iOS **['en-GB', 'es-GB'] or for Android **['en_GB, 'es_GB]**
  Future<List<Locale>> get preferredLanguages async {
    final List version = await _channel.invokeMethod('preferredLanguages');
    List<Locale> preferedLocales = List();
    for(String localeJsonStr in version) {
      Map<String, dynamic> localeJson = jsonDecode(localeJsonStr);
      if(localeJson != null) {
        final locale = _localeFromJson(localeJson);
        preferedLocales.add(locale);
      }
    }
    return preferedLocales;
  }


  Locale _localeFromJson(Map<String, dynamic> json) {
    if (json == null) {
    return null;
  }
  final _languageCode = json["languageCode"];
  final _countryCode = json["countryCode"];
  final _scriptCode = json["scriptCode"];

  if (_scriptCode != null && _countryCode != null && _languageCode != null) {
    return Locale.fromSubtags(
        languageCode: _languageCode,
        countryCode: _countryCode,
        scriptCode: _scriptCode);
  } else if (_languageCode != null && _countryCode != null) {
    return Locale(_languageCode, _countryCode);
  } else if (_languageCode != null) {
    return Locale(_languageCode);
  }
  return null;
  }
}
