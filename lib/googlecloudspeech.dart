import 'dart:async';

import 'package:flutter/services.dart';

class Googlecloudspeech {
  static const MethodChannel _channel =
      const MethodChannel('googlecloudspeech');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
