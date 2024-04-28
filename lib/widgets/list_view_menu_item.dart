import 'package:cool_devtool/widgets/generic_screen.dart';
import 'package:flutter/material.dart';

import '../models/debug_options.dart';

class MenuItem extends StatefulWidget {
  final DebugOptions option;
  const MenuItem({super.key, required this.option});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    GenericDevtoolScreen(currentOption: widget.option)));
          },
          child: SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                Switch(
                    value: widget.option.object.optionValue,
                    onChanged: (value) {
                      setState(() {
                        widget.option.reverseValue();
                      });
                    }),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(widget.option.object.title),
                ),
                const Icon(Icons.question_mark)
              ]),
            ),
          ),
        ),
        Container(
          height: 1,
          decoration: const BoxDecoration(color: Colors.grey),
        ),
      ],
    );
  }
}
