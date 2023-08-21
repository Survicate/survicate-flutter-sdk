import 'package:flutter/material.dart';
import 'package:survicate_sdk/survicate_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SurvicateSdk _survicate = SurvicateSdk();

  @override
  void initState() {
    super.initState();
    _survicate.initializeSdk();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              child: const Text('Enter Screen: Home'),
              onPressed: () {
                _survicate.enterScreen('Home');
              },
            ),
            TextButton(
              child: const Text('Leave Screen: Home'),
              onPressed: () {
                _survicate.leaveScreen('Home');
              },
            ),
            TextButton(
              child: const Text('Invoke Event: Event'),
              onPressed: () {
                _survicate.invokeEvent('Event');
              },
            ),
            TextButton(
              child: const Text('Set User Trait'),
              onPressed: () {
                _survicate.setUserTrait('Name', 'Jane Doe');
              },
            ),
            TextButton(
              child: const Text('Set User Id'),
              onPressed: () {
                _survicate.setUserId('1234567890');
              },
            ),
            TextButton(
              child: const Text('Reset'),
              onPressed: () {
                _survicate.reset();
              },
            ),
          ],
        ),
      ),
    );
  }
}
