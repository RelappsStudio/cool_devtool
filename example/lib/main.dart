import 'dart:math';

import 'package:cool_devtool/cool_devtool.dart';
import 'package:cool_devtool/inspector_tools/debug_options.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      checkerboardOffscreenLayers:
          DebugOptions.offscreenLayers.object.optionValue,
      checkerboardRasterCacheImages:
          DebugOptions.rasterCacheImages.object.optionValue,
      debugShowMaterialGrid: DebugOptions.materialGrid.object.optionValue,
      showSemanticsDebugger: DebugOptions.semanticsDebugger.object.optionValue,
      showPerformanceOverlay:
          DebugOptions.performanceOverlay.object.optionValue,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("oversized image example"),
              SizedBox(
                height: 200,
                width: 200,
                child: Image.network(
                    'https://storage.googleapis.com/cms-storage-bucket/acb0587990b4e7890b95.png'),
              ),
              SizedBox(
                height: 100,
              ),
              AnimatedContainer(
                // Use the properties stored in the State class.
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: _borderRadius,
                ),
                // Define how long the animation should take.
                duration: const Duration(seconds: 1),
                // Provide an optional curve to make the animation feel smoother.
                curve: Curves.fastOutSlowIn,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Create a random number generator.
                      final random = Random();

                      // Generate a random width and height.
                      _width = random.nextInt(300).toDouble();
                      _height = random.nextInt(300).toDouble();

                      // Generate a random color.
                      _color = Color.fromRGBO(
                        random.nextInt(256),
                        random.nextInt(256),
                        random.nextInt(256),
                        1,
                      );

                      // Generate a random border radius.
                      _borderRadius =
                          BorderRadius.circular(random.nextInt(100).toDouble());
                    });
                  },
                  child: Text('Animate container transformation')),
              SizedBox(
                height: 100,
              ),
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DevtoolsMenuScreen()));
                  },
                  child: const Text('Open devtools menu'))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
