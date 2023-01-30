
# flutter_responsive_scale
**A flutter package for making beautiful data loading screen with next page route event**

## Demo
![screenshot](https://user-images.githubusercontent.com/70679949/215478460-e0e80389-4060-49c3-893b-a89ff5e542a8.gif)

## Features
- Beautiful loading screen UI
- Event callback after task completion
- Event navigate to next screen after task complete
- Parameters for Compete UI control

## Usage

### Add dependency

Please check the latest version before installation.
If there is any problem with the new version, please use the previous version

```yaml
dependencies:
  flutter:
    sdk: flutter
  # add flutter_responsive_scale
  flutter_loading_screen: ^{latest version}
```

### Add the following imports to your Dart code

```dart
import 'package:flutter_loading_screen/flutter_loading_screen.dart';
```

### Property

| Property         | Type      | Parameter               | Description                           |
|------------------|-----------|-------------------------|---------------------------------------|
| initializers     | Parameter | double required         | initial task parameter                |
| navigateToWidget | Function  | dynamic required        | Parameter for navigate to Next page.  |
| image            | Parameter | assets image (optional) | parameter for background assets image |

## Examples

```dart

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_loading_screen/flutter_loading_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading Screen Example',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: const LoadingScreenExample(),
    );
  }
}

class LoadingScreenExample extends StatefulWidget {
  const LoadingScreenExample({super.key});

  @override
  LoadingScreenExampleState createState() => LoadingScreenExampleState();
}

class LoadingScreenExampleState extends State<LoadingScreenExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLoadingScreen(
        initializers: const <dynamic>[TimeMessages.timer],
        navigateToWidget: Scaffold(
          appBar: AppBar(
            title: const Text('Done'),
          ),
        ),
        loaderColor: Colors.white,
        image: Image.asset(
          'assets/lake.jpg',
          fit: BoxFit.cover,
        ),
        title: 'Welcome in demo app',
        backgroundColor: Colors.black,
        styleTextUnderTheLoader: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.lightGreenAccent,
        ),
      ),
    );
  }
}

class TimeMessages {
  static Future timer(MessageState state) async {
    await Future.delayed(const Duration(seconds: 20), () {
      state.setMessage = DateTime.now().toIso8601String();
    });
  }
}

```

## Authors
- [@subhashDev11](https://github.com/subhashDev11)

## 🚀 About Me
I'm a flutter developer...

## 🔗 Links
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://subhashdev121.github.io/subhash/#/)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/subhashcs)
[![medium](https://img.shields.io/badge/medium-000?style=for-the-badge&logo=medium&logoColor=white)](https://medium.com/@subhashchandrashukla)

![Logo](https://i.ibb.co/2szbbHF/code-xposer.png)

## License

[MIT](https://choosealicense.com/licenses/mit/)
