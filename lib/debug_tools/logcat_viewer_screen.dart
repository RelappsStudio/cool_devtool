import 'package:cool_devtool/tools/logcat_live_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogcatViewerScreen extends StatefulWidget {
  const LogcatViewerScreen({super.key});

  @override
  State<LogcatViewerScreen> createState() => _LogcatViewerScreenState();
}

class _LogcatViewerScreenState extends State<LogcatViewerScreen> {
  final StringBuffer _logBuffer = StringBuffer();
  int _groupValue = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      LogcatMonitor.addListen(_listenStream);
    } on PlatformException {
      debugPrint('Failed to listen Stream of log.');
    }
    await LogcatMonitor.startMonitor("*.*");
  }

  void _listenStream(dynamic value) {
    if (value is String) {
      if (mounted) {
        setState(() {
          _logBuffer.writeln(value);
        });
      } else {
        _logBuffer.writeln(value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logcat Monitor example app'),
      ),
      body: Column(
        children: [
          const Text("Logcat log:"),
          logboxBuild(context),
          Column(
            children: [
              RadioListTile(
                title: const Text("logcat filter: *.*"),
                value: 0,
                groupValue: _groupValue,
                onChanged: (value) async {
                  setState(() {
                    _groupValue = value ?? 0;
                    _logBuffer.clear();
                  });
                  await LogcatMonitor.startMonitor("*.*");
                },
              ),
              RadioListTile(
                title: const Text("logcat filter: flutter,LogcatMonPlugin,S:*"),
                value: 1,
                groupValue: _groupValue,
                onChanged: (value) async {
                  setState(() {
                    _groupValue = value ?? 0;
                    _logBuffer.clear();
                  });
                  await LogcatMonitor.startMonitor(
                      "flutter:*,LogcatMonPlugin:*,*:S");
                },
              ),
            ],
          ),
          TextButton(
            onPressed: () async {
              debugPrint("called debugPrint from flutter!");
            },
            style: TextButton.styleFrom(
                elevation: 2, backgroundColor: Colors.amber[100]),
            child: const Text("call debugPrint on flutter"),
          ),
          TextButton(
            onPressed: () async {
              clearLog();
            },
            style: TextButton.styleFrom(
                elevation: 2, backgroundColor: Colors.amber[100]),
            child: const Text("Clear"),
          ),
        ],
      ),
    );
  }

  Widget logboxBuild(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: Colors.blueAccent,
              width: 1.0,
            ),
          ),
          child: Scrollbar(
            thickness: 10,
            radius: const Radius.circular(20),
            child: SingleChildScrollView(
              reverse: true,
              scrollDirection: Axis.vertical,
              child: Text(
                _logBuffer.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearLog() async {
    LogcatMonitor.clearLogcat;
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      _logBuffer.clear();
      _logBuffer.writeln("log buffer cleared");
    });
  }
}
