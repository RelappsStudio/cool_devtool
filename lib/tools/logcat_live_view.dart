import 'dart:async';

import 'package:flutter/services.dart';

class LogcatMonitor {
  static const MethodChannel _channel =
      MethodChannel("cool_devtool/methods");
  static const EventChannel _stream = EventChannel("cool_devtool/events");
  static late StreamSubscription _streamSubscription;

  /// Adds a subscription to this stream.
  static void addListen(void Function(dynamic) onData) {
    _streamSubscription = _stream.receiveBroadcastStream().listen(onData);
  }

  /// Cancels a subscription to this stream.
  static void cancelListen() {
    _streamSubscription.cancel();
  }

  /// Runs a logcat command and starts monitoring it through the event stream.
  static Future<bool?> startMonitor(String options) async {
    bool? result = await _channel
        .invokeMethod('startMonitor', <String, String>{'options': options});
    return result;
  }

  /// Interrupt the logcat command and stop monitoring it through the event stream.
  static Future<bool?> stopMonitor() async {
    bool? result = await _channel.invokeMethod('stopMonitor');
    return result;
  }

  /// Runs a logcat command with options and returns the result.
  ///
  /// use -d option to "Dump the log and then exit (don't block)."
  static Future<String?> runLogcat(String options) async {
    final String? result = await _channel
        .invokeMethod('runLogcat', <String, String>{'options': options});
    return result;
  }

  /// Runs a logcat log dump command and returns the result.
  static Future<String?> get getLogcatDump async {
    final String? result = await _channel
        .invokeMethod('runLogcat', <String, String>{'options': "-d"});
    return result;
  }

  /// Runs a logcat clear command and returns the result.
  static Future<String?> get clearLogcat async {
    final String? result = await _channel
        .invokeMethod('runLogcat', <String, String>{'options': "-c"});
    return result;
  }
}
