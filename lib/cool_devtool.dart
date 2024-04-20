library cool_devtool;

import 'dart:io';

import 'package:cool_devtool/debug_tools/logcat_viewer_screen.dart';
import 'package:cool_devtool/extensions/iterable_extensions.dart';
import 'package:cool_devtool/inspector_tools/debug_options.dart';
import 'package:cool_devtool/widgets/list_view_menu_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'local_variables.dart';

class DevtoolsMenuScreen extends StatefulWidget {
  final bool? performanceOverlayController;
  const DevtoolsMenuScreen({
    super.key,
    this.performanceOverlayController,
  });

  @override
  State<DevtoolsMenuScreen> createState() => _DevtoolsMenuScreenState();
}

class _DevtoolsMenuScreenState extends State<DevtoolsMenuScreen> {
  @override
  void initState() {
    performanceOverlayController = widget.performanceOverlayController ?? false;
    super.initState();
  }

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
               // final type = widget.coreWidget;
                setState(() {
                  // context.findAncestorWidgetOfExactType<this.runtimeType>();
                  // if (thisMaterialApp != null) {
                  //   thisMaterialApp.createState();
                  // }
                });
              },
              child: const Row(
                children: [
                  Text('Refresh'),
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
            DebugOptions.values
                .map((e) => MenuItem(
                      option: e,
                    ) as Widget)
                .intersperse(_separator())
                .toList(),
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
        InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LogcatViewerScreen()));
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
                  child: Text('Open logcat'),
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