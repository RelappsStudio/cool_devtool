<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This is devtools package. Use flutter devtools on the go. Just install debug app version and enjoy all the helpful tools to inspect your app

## Features

All you could do with IDE of your choice- always with you:
- Slowing animations
- Highlight repaints
- Inspect oversized images
- Show guidelines
- Disable opacity layers
- Paint layer borders
- and more...

## Getting started

To use base functionalities just set up navigation to devtools screen
```
Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DevtoolsMenuScreen()));
```

REMEMER THAT DEBUG FEATURES CAN ONLY BE USED IN DEBUG MODE - RELEASE MODE FUNCTIONALITIES DIFFER

## Advanced functions

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Roadmap
- functional performance overlay
- live logcat view (Android only)
- more functions available for release app version
- translations (?)
- network call hijacker - monitor all your app's network calls in one place
- more tools based on feedback

## Additional information

File issues on package's github paeg. Ideas too ;)
