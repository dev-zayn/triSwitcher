# TriSwitcher

TriSwitcher is a Flutter package that provides a switcher widget with three options instead of the
traditional two. It's perfect for scenarios where you need to toggle between three states
effortlessly.

## Installation

To use TriSwitcher, add the following dependency to your `pubspec.yaml` file:

`yaml`
```
dependencies:
  tri_switcher: ^0.0.4
```

Then import the package in your Dart code:

```import 'package:tri_switcher/tri_switcher.dart';```

## Preview

<img src="https://github.com/dev-zayn/triSwitcher/assets/38259126/4dd35227-722c-4f01-a3bc-a6a31ca8c86e" alt="drawing" width="500"/>

https://github.com/dev-zayn/triSwitcher/assets/38259126/ab8f665e-2693-4244-a13b-f47edeab1fb9

## Properties
- final ValueChanged<SwitchPosition> onChanged;
- final SwitchPosition? initialPosition;
- final Color firstStateBackgroundColor;
- final Color secondStateBackgroundColor;
- final Color thirdStateBackgroundColor;
- final Color firstStateToggleColor;
- final Color secondStateToggleColor;
- final Color thirdStateToggleColor;
- final List<widget<x>>? icons;
- final BoxShape toggleShape;
- final BorderRadiusGeometry borderRadius;
- final Duration duration;
- final Curve curve;
- final double? size;

## Usage

Simply add the TriSwitcher widget to your Flutter app and define the callback function to handle state changes.

`Dart`
```
TriSwitcher(
  onChanged: (SwitchPosition position) {
    // Handle state changes here
  },
),
```
## Example

`Dart`
```
import 'package:flutter/material.dart';
import 'package:tri_switcher/tri_switcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriSwitcher Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SwitcherExample(),
    );
  }
}

class SwitcherExample extends StatelessWidget {
  const SwitcherExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              'TriSwitcher Example',
              style: TextStyle(color: Colors.deepPurple.shade900),
            )),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ThemeMode',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple.shade900)),
                TriSwitcher(
                  initialPosition: SwitchPosition.left,
                  firstStateBackgroundColor: Colors.deepPurple,
                  secondStateBackgroundColor: Colors.deepPurple.shade200,
                  thirdStateBackgroundColor: Colors.deepPurple.shade400,
                  thirdStateToggleColor: Colors.deepPurple.shade900,
                  icons: const [
                    Icon(Icons.sunny, color: Colors.amber),
                    Icon(Icons.nightlight_round, color: Colors.purple),
                    Icon(Icons.settings_outlined, color: Colors.white),
                  ],
                  onChanged: (SwitchPosition position) {
                    print('Switch position: $position');
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
```
