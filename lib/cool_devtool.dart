library cool_devtool;

import 'dart:io';

import 'package:cool_devtool/widgets/logcat_viewer_screen.dart';
import 'package:cool_devtool/models/debug_options.dart';
import 'package:cool_devtool/widgets/list_view_menu_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DevtoolsMenuScreen extends StatefulWidget {
  const DevtoolsMenuScreen({
    super.key,
  });

  @override
  State<DevtoolsMenuScreen> createState() => _DevtoolsMenuScreenState();
}

class _DevtoolsMenuScreenState extends State<DevtoolsMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DevTools'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                WidgetsFlutterBinding.ensureInitialized()
                    .reassembleApplication();
              },
              child: const Row(
                children: [
                  Text('Hot reload'),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.refresh),
                ],
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: _buildLogcatTile() +
            DebugOptions.values.map((e) {
              if (kDebugMode) {
                return MenuItem(
                  option: e,
                ) as Widget;
              } else {
                if (!e.object.isDebugOnly) {
                  return MenuItem(
                    option: e,
                  ) as Widget;
                }
              }
              return const SizedBox();
            }).toList(),
      ),
    );
  }

  Widget _separator() {
    return Container(
      height: 1,
      decoration: const BoxDecoration(color: Colors.grey),
    );
  }

  List<Widget> _buildLogcatTile() {
    if (Platform.isAndroid) {
      return [
        _separator(),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LogcatViewerScreen()));
          },
          child: const SizedBox(
            height: 60,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                Icon(Icons.pets),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text('Open logcat (WIP)'),
                ),
                Icon(Icons.arrow_right)
              ]),
            ),
          ),
        ),
        _separator()
      ];
    } else {
      return [];
    }
  }
}
