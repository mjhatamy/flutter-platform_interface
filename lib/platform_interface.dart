import 'package:flutter/services.dart';
import 'locale_extension.dart';

/// A Simple plug-in that can be used to interogate a device( iOS or Android) to obtain a list of current set up locales and languages
class PlatformInterface {
  static const MethodChannel _channel =
      const MethodChannel('io.marands.flutter/platform_interface');
  static PlatformLocale get locale => PlatformLocale(_channel);
}