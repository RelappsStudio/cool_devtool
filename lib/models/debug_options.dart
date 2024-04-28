import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import '../local_variables.dart';

enum DebugOptions {
  slowAnimations,
  performanceOverlay,
  showGuidelines,
  showBaselines,
  showOversizedImages,
  paintPointers,
  paintLayerBorders,
  repaintRainbow,
  disableOpacity,
  disableClipLayers,
  offscreenLayers,
  rasterCacheImages,
  materialGrid,
  semanticsDebugger,
  needsLayoutStacks,
  needsPaintStacks
}

class Option {
  final String title;
  bool optionValue;
  final String description;
  final bool isDebugOnly;

  Option(
      {required this.title,
      required this.optionValue,
      required this.description,
      this.isDebugOnly = false});
}

extension ReverseDebugOption on DebugOptions {
  void reverseValue() {
    switch (this) {
      case DebugOptions.showOversizedImages:
        debugInvertOversizedImages = !debugInvertOversizedImages;
        break;
      case DebugOptions.showBaselines:
        debugPaintBaselinesEnabled = !debugPaintBaselinesEnabled;
        break;
      case DebugOptions.showGuidelines:
        debugPaintSizeEnabled = !debugPaintSizeEnabled;
        break;
      case DebugOptions.slowAnimations:
        timeDilation = timeDilation == 5.0 ? 1.0 : 5.0;
        break;
      case DebugOptions.paintPointers:
        debugPaintPointersEnabled = !debugPaintPointersEnabled;
        break;
      case DebugOptions.paintLayerBorders:
        debugPaintLayerBordersEnabled = !debugPaintLayerBordersEnabled;
        break;
      case DebugOptions.repaintRainbow:
        debugRepaintRainbowEnabled = !debugRepaintRainbowEnabled;
        break;
      case DebugOptions.needsLayoutStacks:
        debugPrintMarkNeedsLayoutStacks = !debugPrintMarkNeedsLayoutStacks;
        break;
      case DebugOptions.needsPaintStacks:
        debugPrintMarkNeedsPaintStacks = !debugPrintMarkNeedsPaintStacks;
        break;
      case DebugOptions.performanceOverlay:
        performanceOverlayController = !performanceOverlayController;
        WidgetsFlutterBinding.ensureInitialized().reassembleApplication();
        break;
      case DebugOptions.disableOpacity:
        debugDisableOpacityLayers = !debugDisableOpacityLayers;
        break;
      case DebugOptions.disableClipLayers:
        debugDisableClipLayers = !debugDisableClipLayers;
        break;
      case DebugOptions.offscreenLayers:
        offscreenLayersController = !offscreenLayersController;
        WidgetsFlutterBinding.ensureInitialized().reassembleApplication();
        break;
      case DebugOptions.rasterCacheImages:
        rasterCacheImagesController = !rasterCacheImagesController;
        WidgetsFlutterBinding.ensureInitialized().reassembleApplication();
        break;
      case DebugOptions.materialGrid:
        materialGridController = !materialGridController;
        WidgetsFlutterBinding.ensureInitialized().reassembleApplication();
        break;
      case DebugOptions.semanticsDebugger:
        semanticsDebuggerController = !semanticsDebuggerController;
        WidgetsFlutterBinding.ensureInitialized().reassembleApplication();
        break;
    }
  }
}

extension DebugOptionsDetails on DebugOptions {
  Option get object {
    switch (this) {
      case DebugOptions.showOversizedImages:
        return Option(
            title: 'Highlight oversized images',
            optionValue: debugInvertOversizedImages,
            isDebugOnly: true,
            description:
                '*images that are larger than they should be will be upside down with inverted colors');
      case DebugOptions.showBaselines:
        return Option(
            title: 'Show baselines',
            optionValue: debugPaintBaselinesEnabled,
            isDebugOnly: true,
            description:
                '*makes all baselines visible. Baselines are horizontal lines used to position text');
      case DebugOptions.showGuidelines:
        return Option(
          title: "Show guidelines",
          optionValue: debugPaintSizeEnabled,
          isDebugOnly: true,
          description:
              '*draws guidelines over your app that display render boxes, alignments, paddings, scroll views, clippings and spacers',
        );
      case DebugOptions.slowAnimations:
        return Option(
            title: 'Slow animations',
            optionValue: timeDilation == 5.0,
            description: '*slows down animations 5 times');
      case DebugOptions.paintPointers:
        return Option(
            title: 'Paint pointers',
            optionValue: debugPaintPointersEnabled,
            isDebugOnly: true,
            description:
                '*highlights any objects that you tap in teal. This can help you determine if an object fails to hit test. This might happen if the object falls outside the bounds of its parent and thus not considered for hit testing in the first place.');
      case DebugOptions.paintLayerBorders:
        return Option(
            title: 'Paint layer borders',
            optionValue: debugPaintLayerBordersEnabled,
            isDebugOnly: true,
            description:
                '*find the boundaries of each layer. This flag results in outlining each layer\'s bounds in orange.');
      case DebugOptions.repaintRainbow:
        return Option(
            title: 'Repaint rainbow',
            optionValue: debugRepaintRainbowEnabled,
            isDebugOnly: true,
            description:
                '*display a repainted layer. Whenever a layer repaints, it overlays with a rotating set of colors.');
      case DebugOptions.needsLayoutStacks:
        return Option(
            title: 'Inspect layouts (logcat)',
            optionValue: debugPrintMarkNeedsLayoutStacks,
            isDebugOnly: true,
            description:
                '*To determine if your app creates more layouts than expected the framework outputs stack traces to the console/logcat to explain why your app marks each render object to be laid out.');
      case DebugOptions.needsPaintStacks:
        return Option(
            title: 'Inspect paints (logcat)',
            optionValue: debugPrintMarkNeedsPaintStacks,
            isDebugOnly: true,
            description:
                '*determine if your app paints more layouts than expected, visible in output/logcat');
      case DebugOptions.disableOpacity:
        return Option(
            title: 'Disable opacity layers',
            optionValue: debugDisableOpacityLayers,
            isDebugOnly: true,
            description:
                '*disables all opacity effects, can be used to check whether excessive use of opacity effects is affecting performance.');
      case DebugOptions.performanceOverlay:
        return Option(
            title: 'Show performance overlay',
            optionValue: performanceOverlayController,
            description:
                '*enables displaying performance overlay over the application');
      case DebugOptions.disableClipLayers:
        return Option(
            title: 'Disable clip layers',
            optionValue: debugDisableClipLayers,
            isDebugOnly: true,
            description:
                '*debug whether objects being clipped are painting excessively in clipped areas. Can also be used to check whether excessive use of clipping is affecting performance.');
      case DebugOptions.offscreenLayers:
        return Option(
            title: 'Show offscreen layers',
            optionValue: offscreenLayersController,
            description:
                '*Turns on checkerboarding of layers rendered to offscreen bitmaps.');
      case DebugOptions.rasterCacheImages:
        return Option(
            title: 'Show cached images',
            optionValue: rasterCacheImagesController,
            description: '*Turns on checkerboarding of raster cache images.');
      case DebugOptions.materialGrid:
        return Option(
            title: 'Show material grid',
            optionValue: materialGridController,
            isDebugOnly: true,
            description:
                'Turns on a GridPaper overlay that paints a baseline grid');
      case DebugOptions.semanticsDebugger:
        return Option(
            title: 'Semantic debugger',
            optionValue: semanticsDebuggerController,
            description:
                '*Turns on an overlay that shows the accessibility information reported by the framework.');
    }
  }
}
