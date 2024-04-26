import 'package:cool_devtool/inspector_tools/debug_options.dart';
import 'package:flutter/material.dart';

class PerformanceWrapper extends StatefulWidget {
  final MaterialApp child;
  final TextDirection textDirection;
  const PerformanceWrapper(
      {super.key, required this.child, this.textDirection = TextDirection.ltr});

  @override
  State<PerformanceWrapper> createState() => _PerformanceWrapperState();
}

class _PerformanceWrapperState extends State<PerformanceWrapper> {
  bool internalPerfomanceController = false;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    internalPerfomanceController = !internalPerfomanceController;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        (DebugOptions.performanceOverlay.object.optionValue ||
                internalPerfomanceController)
            ? PerformanceOverlay.allEnabled()
            : SizedBox(),
        widget.child
      ],
    );
  }
}
