import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:platform_interface/src/parser.dart';
import 'dart:async';
import 'dart:convert';

import 'package:platform_interface/src/pigeons/platform_locale_classes.dart';

extension on PiLocale {
  Locale toLocale() {
    if (this.scriptCode != null && this.countryCode != null && this.languageCode != null) {
      return Locale.fromSubtags(
          languageCode: this.languageCode,
          countryCode: this.countryCode,
          scriptCode: this.scriptCode);
    } else if (this.languageCode != null && this.countryCode != null) {
      return Locale(this.languageCode, this.countryCode);
    } else if (this.languageCode != null) {
      return Locale(this.languageCode);
    } else {
      throw PlatformException(
          code: 'channel-error',
          message: 'Returned value of Type "PiLocale" from Platform is not a valid item. Dump: $this}',
          details: null);
    }
  }
}

class PlatformLocale {
  MethodChannel _channel;
  PlatformLocale(MethodChannel channel) {
    this._channel = channel;
  }

  /// Returns a [String] of the currently set DEVICE locale made up of the language and the region
  /// (e.g. en-US or en_US)
  Future<Locale> get currentLocale async {
    final Map<dynamic, dynamic> replyMap =  await _channel.invokeMethod('currentLocale');
    PiLocale piLocale = PlatformChannelParser.replyParser(replyMap, PiLocale.fromMap);
    if(piLocale == null) {
      return null;
    }
    return piLocale.toLocale();
  }

  /// Returns a [List] of locales from the device
  /// the first in the list should be the current one set on the device
  /// for example iOS **['en-GB', 'es-GB'] or for Android **['en_GB, 'es_GB]**
  Future<List<Locale>> get preferredLanguages async {
    final Map<dynamic, dynamic> replyMap =  await _channel.invokeMethod('preferredLanguages');

    List<Map<dynamic, dynamic>> items = PlatformChannelParser.replyParser(replyMap, ListOfMapData.fromMap);
    print("Reply: $items\n");
    if(items == null) {
      return null;
    }
    List<Locale> preferredLocales = List();
    for (Map<dynamic, dynamic> mapData in items) {
      PiLocale item = PiLocale.fromMap(mapData);
      if(item != null) {
        preferredLocales.add(item.toLocale());
      }
    }
    return preferredLocales;
  }
}
