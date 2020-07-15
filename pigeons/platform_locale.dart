library platform_interface.platform_local;
import 'package:pigeon/pigeon_lib.dart';
import 'dart:core';

class PiLocale {
  String languageCode;
  String countryCode;
  String scriptCode;
}

@HostApi()
abstract class PlatformLocale {
  PiLocale _currentLocale();
  //PreferredLanguagesList preferredLanguages();
  //List<PiLocale> preferredLanguages2();
}