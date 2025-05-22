# Mobile SDK - Flutter ![pub version](https://img.shields.io/pub/v/survicate_sdk)

The Survicate Mobile SDK allows you to collect feedback from your mobile app users. Installed in your app, the SDK will enable you to trigger targeted surveys to better understand your users and collect their opinions about your products. 

The SDK is maintained and supported by [Survicate - The Customer Experience & Survey Software](https://survicate.com/software/mobile-app-surveys/).

The detailed documentation is available [here](https://developers.survicate.com/mobile-sdk/flutter). 

## Requirements

* Using Survicate Mobile SDK requires an account at [survicate.com](https://survicate.com). You can create your account [here](https://panel.survicate.com/signup) for free, or become invited to your company account by one of your colleagues.
* Additionally, please check [iOS](/mobile-sdk/ios/) and [Android](/mobile-sdk/android/) library requirements, as they're applicable too.

## Installation
To use this plugin, add `survicate_sdk` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

## Configuration

### Configuration for Android

1. Configure your *workspace key* in `AndroidManifest.xml` file.

```xml {{title: 'AndroidManifest.xml'}}
<application
    android:name=".MyApp"
>
    <!-- ... -->
    <meta-data android:name="com.survicate.surveys.workspaceKey" android:value="YOUR_WORKSPACE_KEY"/>
</application>
```

2. Add the Survicate Maven repository to your project `build.gradle` located under `android` directory.

```groovy {{title: "Project's build.gradle" }}
allprojects {
    repositories {
        // ...
        maven { url 'https://repo.survicate.com' }
    }
}
```

### Configuration for iOS

1. Add workspace key to your `Info.plist` file.
   - Create `Survicate` *Dictionary*.
   - Define `WorkspaceKey` *String* in `Survicate` *Dictionary*.
   Your `Info.plist` file should looks like this:
   ![Info.plist example](/ios-infoplist.png)
2. Run `pod update` in your `ios` directory.

### Initialization

Initialize the SDK in your application using `initializeSdk()` method. Call this method only once, in the main component (e.g `lib/main.dart` file).

```dart
import 'package:survicate_sdk/survicate_sdk.dart';

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SurvicateSdk.initializeSdk();
  }
}
```

## Usage
```dart
import 'package:survicate_sdk/survicate_sdk.dart';
import 'package:survicate_sdk/user_trait.dart';

// Set workspace key in code
SurvicateSdk.setWorkspaceKey("WORKSPACE_KEY");

// Initialize an SDK
SurvicateSdk.initializeSdk();


// Invoke an event
SurvicateSdk.invokeEvent("eventName");

// Invoke an event with properties
Map<String, String> properties = {
  'property1': 'value1',
  'property2': 'value2',
};
SurvicateSdk.invokeEvent('Event', properties);

// Enter a screen
SurvicateSdk.enterScreen("screenName");

// Leave a screen
SurvicateSdk.leaveScreen("screenName");

// Set a single user trait
UserTrait userIdTrait = UserTrait('user_id', 'id');
SurvicateSdk.setUserTrait(userIdTrait);

// Set multiple user traits
List<UserTrait> traits = [
  UserTrait('name', 'John'),
  UserTrait('age', 25),
  UserTrait('isPremium', true),
  UserTrait('lastLogin', DateTime.now()),
  UserTrait('timeOfPurchase', DateTime.now()),
];
SurvicateSdk.setUserTraits(traits);

// Set locale
SurvicateSdk.setLocale('en-US');

// Add an event listener
SurvicateEventListener listener = SurvicateEventListener(
  onSurveyDisplayed: (SurveyDisplayedEvent event) { },  // onSurveyDisplayed
  onQuestionAnswered: (QuestionAnsweredEvent event) { }, // onQuestionAnswered
  onSurveyClosed: (SurveyClosedEvent event) { },  // onSurveyClosed
  onSurveyCompleted: (SurveyCompletedEvent event) { }, // onSurveyCompleted
);
SurvicateSdk.addSurvicateEventListener(listener);

// Remove an event listener
SurvicateSdk.removeSurvicateEventListener(listener);

// Reset the SDK
SurvicateSdk.reset();
```

## Issues

Got an Issue?

To make things more streamlined, we’ve transitioned our issue reporting to our customer support platform. If you encounter any bugs or have feedback, please reach out to our customer support team. Your insights are invaluable to us, and we’re here to help ensure your experience is top-notch!

Contact us via Intercom in the application, or drop us an email at: [hello@survicate.com]

Thank you for your support and understanding!
