import 'package:flutter/services.dart';

extension ListOfMapData on List<Map<dynamic, dynamic>> {
  // ignore: unused_element
  static List<Map<dynamic, dynamic>> fromMap(dynamic pigeonMap) {
    if(pigeonMap is List) {
      return pigeonMap.map((e) {
        if (e is Map<dynamic, dynamic>) {
          return e;
        } else {
          return null;
        }
      }).toList();
    }
    return null;
  }
}

class PlatformChannelParser {
  static T replyParser<T, E>(final Map<dynamic, dynamic> replyMap, T Function(E) fromMap) {
    if (replyMap == null) {
      throw PlatformException(
          code: 'channel-error',
          message: 'Unable to establish connection on channel.',
          details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      E result = replyMap['result'];
      print("${result}");

      if(result == null) {
        return null;
      }
      return fromMap(result);
    }
  }
}