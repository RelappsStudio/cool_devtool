
This is devtools package. Use flutter devtools on the go. Just install debug app version and enjoy all the helpful tools to inspect your app.

## Features

All you could do with IDE of your choice- always with you. In debug mode all features are available.


|**Debug features**|**Profile/release features**|
|:---:|:---:|
|  <br/> Highlight oversized images <br/> Show baselines <br/> Show guidelines <br/> Paint pointers <br/> Paint layer borders <br/> Repaint rainbow <br/> Inspect layouts (logcat) <br/> Inspect paints (logcat) <br/> Disable opacity layers <br/> Disable clip layers <br/> Show material grid <br/> | <br/> Slow animations <br/> <br/>Show performance overlay <br/><br/> Show offscreen layers <br/><br/> Show cached images <br/><br/> Semantic debugger |




![alt text](image.png)

## Getting started

To use base functionalities just set up navigation to devtools screen
```
Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DevtoolsMenuScreen()));
```

To use MaterialApp tools add these lines to your MaterialApp constructor


```
showPerformanceOverlay: DebugOptions.performanceOverlay.object.optionValue,
```

```
checkerboardOffscreenLayers: DebugOptions.offscreenLayers.object.optionValue,
```

```
checkerboardRasterCacheImages:DebugOptions.rasterCacheImages.object.optionValue,
```

```
debugShowMaterialGrid: DebugOptions.materialGrid.object.optionValue,
```

```
showSemanticsDebugger: DebugOptions.semanticsDebugger.object.optionValue,
```


REMEMBER THAT DEBUG FEATURES CAN ONLY BE USED IN DEBUG MODE - RELEASE MODE FUNCTIONALITIES DIFFER


## Roadmap
- live logcat view (Android only)
- tests
- github actions automations
- translations (?)
- network call hijacker - monitor all your app's network calls in one place
- more tools based on feedback

## Additional information

File issues on package's github page. Ideas too ;)
