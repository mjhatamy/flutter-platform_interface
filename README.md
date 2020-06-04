# platform_interface

Gets the device locale data, independent of the app locale settings.

# Usage
```dart
import 'package:platform_interface/platform_interface.dart';
```

then

```dart
List languages = await PlatformInterface.preferredLanguages;
String locale = await PlatformInterface.currentLocale;
```

this should return a list of the preferred/current language locales setup on the device, with the current one being the first in the list or just the currently set device locale.


## iOS


## Updates



## Getting Started

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
