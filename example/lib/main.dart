import 'package:flutter/material.dart';
import 'package:survicate_sdk/survicate_sdk.dart';
import 'package:survicate_sdk/user_trait.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final listener = SurvicateEventListener(
    onSurveyDisplayed: (SurveyDisplayedEvent event) {
      // onSurveyDisplayed
    },
    onQuestionAnswered: (QuestionAnsweredEvent event) {
      // onQuestionAnswered
    },
    onSurveyClosed: (SurveyClosedEvent event) {
      // onSurveyClosed
    },
    onSurveyCompleted: (SurveyCompletedEvent event) {
      // onSurveyCompleted
    },
  );

  @override
  void initState() {
    super.initState();
    SurvicateSdk.setWorkspaceKey("7fa89158babd1961d1082aa93728d431");
    SurvicateSdk.initializeSdk();
    SurvicateSdk.addSurvicateEventListener(listener);
  }

  @override
  void dispose() {
    SurvicateSdk.removeSurvicateEventListener(listener);
    super.dispose();
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
                SurvicateSdk.enterScreen('Home');
              },
            ),
            TextButton(
              child: const Text('Leave Screen: Home'),
              onPressed: () {
                SurvicateSdk.leaveScreen('Home');
              },
            ),
            TextButton(
              child: const Text('Invoke Event: Event'),
              onPressed: () {
                SurvicateSdk.invokeEvent('Event');
              },
            ),
            TextButton(
              child: const Text('Invoke Event with Properties: Event'),
              onPressed: () {
                Map<String, String> properties = {
                  'property1': 'value1',
                  'property2': 'value2',
                };
                SurvicateSdk.invokeEvent('Event', eventProperties: properties);
              },
            ),
            TextButton(
              child: const Text('Set User Trait'),
              onPressed: () {
                UserTrait trait = UserTrait.string('Name', 'Jane Doe');
                SurvicateSdk.setUserTrait(trait);
              },
            ),
            TextButton(
              child: const Text('Set User Traits'),
              onPressed: () {
                List<UserTrait> traits = [
                  UserTrait.string("name", "Jane Doe"),
                  UserTrait.num("age", 25),
                  UserTrait.bool("isPremium", true),
                  UserTrait.dateTime("lastLogin", DateTime.now()),
                ];
                SurvicateSdk.setUserTraits(traits);
              },
            ),
            TextButton(
              child: const Text('Reset'),
              onPressed: () {
                SurvicateSdk.reset();
              },
            ),
          ],
        ),
      ),
    );
  }
}
