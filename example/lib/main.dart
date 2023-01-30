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
