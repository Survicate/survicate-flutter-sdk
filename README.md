# Mobile SDK - Flutter

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

SurvicateSdk.initializeSdk();
SurvicateSdk.invokeEvent("eventName");
SurvicateSdk.enterScreen("screenName");
SurvicateSdk.leaveScreen("screenName");
SurvicateSdk.setUserTrait("traitName", "traitValue");
Map<String, String> userTraits = {
  'age': '30',
  'gender': 'male',
  'occupation': 'developer'
};
SurvicateSdk.setUserTraits(userTraits);
SurvicateSdk.reset();
```

## Changelog

The Survicate Mobile SDK change log can be found [here](https://developers.survicate.com/mobile-sdk/flutter/#changelog)

## Using SDK

Survicate allows you to launch precisely targeted surveys inside your app. In the Survicate Panel, you can set conditions that need to be met for the surveys to appear. Users matching conditions defined in the Survicate panel will see the survey automatically. Here's a list of conditions you can use to target your surveys:

- Name of the screen that a user currently sees
- Any application event
- User attributes and identities
- Language of the device
- Operating system

Make sure to list all the screens and events described in your application.
Once you got this covered, you or any person responsible for creating and managing surveys will be able to trigger surveys from the Survicate panel with no need for you to update the application.

### Targeting a survey by screen name

A survey can appear when a user is viewing a specific screen. For example, a survey can be triggered to show up on the application's home screen after a user spends more than ten seconds there. To set it up, you need to send information to Survicate about the user entering and leaving a screen.

_Note: Multiple active screens are allowed. In specific, calling enterScreen() does not make the previous screen to be discarded. Be sure to call leaveScreen() when you no longer want the screen to be treated as active._

```dart
// ...
SurvicateSdk.enterScreen("screenName");
// ...
SurvicateSdk.leaveScreen("screenName");
```

_Screen name is case sensitive. If there's any discrepancy between what's declared in the ‘Screens’ tab of the Target section in the Survicate panel and the application code, the survey will not appear._

### Events-based survey targeting

Survicate Android SDK allows you to launch surveys based on events your users trigger in your app. Your survey will instantly after an event occurs in your app.

```dart
SurvicateSdk.invokeEvent("eventName");
```

_Event name is case sensitive. If there is any discrepancy between what's declared in the ‘Triggers’ tab of the Target section in the Survicate panel and the application code, the survey will not appear._

### Passing user attributes

You can pass user attributes to Survicate as an additional layer of information about your users. Attributes can be used to:
* trigger your surveys
* filter your survey results

```dart
SurvicateSdk.setUserTrait("traitName", "traitValue");

Map<String, String> traits = {
  'user_id': 'YourUserId',
  'name': 'John',
};
SurvicateSdk.setUserTraits(traits);
```

_Bear in mind that user attributes are cached. You only need to provide them once, e.g. when user logs in, not after each `init()`. You can also change their values at any time to trigger a survey._

### Reseting user data for testing purposes

If you need to test surveys on your device, `reset()` method might be helpful. This method will reset all user data stored on your device (survey views, attributes, information about answered surveys for the targeting engine).

```dart
SurvicateSdk.reset();
```
