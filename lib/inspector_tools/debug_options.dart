import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import '../local_variables.dart';

enum DebugOptions {
  slowAnimations,
  showGuidelines,
  showBaselines,
  highlightRepaints,
  showOversizedImages,
  paintPointers,
  paintLayerBorders,
  repaintRainbow,
  needsLayoutStacks,
  needsPaintStacks,
  performanceOverlay,
  disableOpacity,
  disableClipLayers,
}

class Option {
  final String title;
  bool debugValue;
  final String description;

  Option(
      {required this.title,
      required this.debugValue,
      required this.description});
}

extension ReverseDebugOption on DebugOptions {
  void reverseValue() {
    switch (this) {
      case DebugOptions.highlightRepaints:
        debugRepaintRainbowEnabled = !debugRepaintRainbowEnabled;
        break;
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
      case DebugOptions.needsLayoutStacks:
        debugPrintMarkNeedsLayoutStacks = !debugPrintMarkNeedsLayoutStacks;
        break;
      case DebugOptions.needsPaintStacks:
        debugPrintMarkNeedsPaintStacks = !debugPrintMarkNeedsPaintStacks;
        break;
      case DebugOptions.performanceOverlay:
        performanceOverlayController = !performanceOverlayController;
        break;
      case DebugOptions.disableOpacity:
        debugDisableOpacityLayers = !debugDisableOpacityLayers;
        break;
      case DebugOptions.disableClipLayers:
        debugDisableClipLayers = !debugDisableClipLayers;
    }
  }
}

extension DebugOptionsDetails on DebugOptions {
  Option get object {
    switch (this) {
      case DebugOptions.highlightRepaints:
        return Option(
            title: 'Highlight repaints',
            debugValue: debugRepaintRainbowEnabled,
            description:
                '* draws a border around all render boxes that changes color every time that box repaints');
      case DebugOptions.showOversizedImages:
        return Option(
            title: 'Highlight oversized images',
            debugValue: debugInvertOversizedImages,
            description:
                '*images that are larger than they should be will be upside down with inverted colors');
      case DebugOptions.showBaselines:
        return Option(
            title: 'Show baselines',
            debugValue: debugPaintBaselinesEnabled,
            description:
                '*makes all baselines visible. Baselines are horizontal lines used to position text');
      case DebugOptions.showGuidelines:
        return Option(
          title: "Show guidelines",
          debugValue: debugPaintSizeEnabled,
          description:
              '*draws guidelines over your app that display render boxes, alignments, paddings, scroll views, clippings and spacers',
        );
      case DebugOptions.slowAnimations:
        return Option(
            title: 'Slow animations',
            debugValue: timeDilation == 5.0,
            description: '*slows down animations 5 times');
      case DebugOptions.paintPointers:
        return Option(
            title: 'Paint pointers',
            debugValue: debugPaintPointersEnabled,
            description:
                '*highlights any objects that you tap in teal. This can help you determine if an object fails to hit test. This might happen if the object falls outside the bounds of its parent and thus not considered for hit testing in the first place.');
      case DebugOptions.paintLayerBorders:
        return Option(
            title: 'Paint layer borders',
            debugValue: debugPaintLayerBordersEnabled,
            description:
                '*find the boundaries of each layer. This flag results in outlining each layer\'s bounds in orange.');
      case DebugOptions.repaintRainbow:
        return Option(
            title: 'Repaint rainbow',
            debugValue: debugRepaintRainbowEnabled,
            description:
                '*display a repainted layer. Whenever a layer repaints, it overlays with a rotating set of colors.');
      case DebugOptions.needsLayoutStacks:
        return Option(
            title: 'Inspect layouts (logcat)',
            debugValue: debugPrintMarkNeedsLayoutStacks,
            description:
                '*To determine if your app creates more layouts than expected the framework outputs stack traces to the console/logcat to explain why your app marks each render object to be laid out.');
      case DebugOptions.needsPaintStacks:
        return Option(
            title: 'Inspect paints (logcat)',
            debugValue: debugPrintMarkNeedsPaintStacks,
            description:
                '*determine if your app paints more layouts than expected, visible in output/logcat');
      case DebugOptions.disableOpacity:
        return Option(
            title: 'Disable opacity layers',
            debugValue: debugDisableOpacityLayers,
            description:
                '*disables all opacity effects, can be used to check whether excessive use of opacity effects is affecting performance.');
      case DebugOptions.performanceOverlay:
        return Option(
            title: 'Show performance overlay  (WIP)',
            debugValue: performanceOverlayController,
            description:
                '*enables displaying performance overlay over the application');
      case DebugOptions.disableClipLayers:
        return Option(
            title: 'Disable clip layers',
            debugValue: debugDisableClipLayers,
            description:
                '*debug whether objects being clipped are painting excessively in clipped areas. Can also be used to check whether excessive use of clipping is affecting performance.');
    }
  }
}
