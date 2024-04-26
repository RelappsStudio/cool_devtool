import 'package:cool_devtool/extensions/iterable_extensions.dart';
import 'package:cool_devtool/inspector_tools/debug_options.dart';
import 'package:flutter/material.dart';

class GenericDevtoolScreen extends StatefulWidget {
  final DebugOptions currentOption;
  const GenericDevtoolScreen({super.key, required this.currentOption});

  @override
  State<GenericDevtoolScreen> createState() => _GenericDevtoolScreenState();
}

class _GenericDevtoolScreenState extends State<GenericDevtoolScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(widget.currentOption.object.title),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Off'),
                Switch(
                    value: widget.currentOption.object.optionValue,
                    onChanged: (value) async {
                      setState(() {
                        widget.currentOption.reverseValue();
                      });
                    }),
                const Text('On')
              ]
                  .intersperse(const SizedBox(
                    width: 30,
                  ))
                  .toList(),
            ),
            Text(widget.currentOption.object.description)
          ]
              .intersperse(const SizedBox(
                height: 50,
              ))
              .toList(),
        ),
      ),
    );
  }
}
