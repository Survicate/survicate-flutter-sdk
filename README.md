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

// Initialization
SurvicateSdk.setWorkspaceKey('WORKSPACE_KEY');
SurvicateSdk.initializeSdk();

// Events
SurvicateSdk.invokeEvent('eventName');
SurvicateSdk.invokeEvent('eventName', eventProperties: {'property1': 'value1', 'property2': 'value2'});

// Screens
SurvicateSdk.enterScreen('screenName');
SurvicateSdk.leaveScreen('screenName');

// User traits
SurvicateSdk.setUserTrait(UserTrait('user_id', 'id'));
SurvicateSdk.setUserTrait(UserTrait('name', 'John'));
SurvicateSdk.setUserTrait(UserTrait('age', 25));
SurvicateSdk.setUserTrait(UserTrait('isPremium', true));
SurvicateSdk.setUserTrait(UserTrait('lastLogin', DateTime.now()));

// Locale
SurvicateSdk.setLocale('en-US');

// Theme
SurvicateSdk.setThemeMode(ThemeMode.auto); // ThemeMode.auto, ThemeMode.light, ThemeMode.dark

// Custom fonts
SurvicateSdk.setFonts(SurvicateFontSystem(
  regular: 'fonts/MyFont-Regular.ttf',
  regularItalic: 'fonts/MyFont-RegularItalic.ttf',
  bold: 'fonts/MyFont-Bold.ttf',
  boldItalic: 'fonts/MyFont-BoldItalic.ttf',
));

// Response attributes
SurvicateSdk.setResponseAttribute(ResponseAttribute.string('plan', 'premium'));
SurvicateSdk.setResponseAttributes([
  ResponseAttribute.string('plan', 'premium', provider: 'crm'),
  ResponseAttribute.bool('isTrialExpired', false),
  ResponseAttribute.num('seats', 5),
  ResponseAttribute.dateTime('renewalDate', DateTime.now()),
]);

// Event listeners
SurvicateEventListener listener = SurvicateEventListener(
  onSurveyDisplayed: (SurveyDisplayedEvent event) {},
  onQuestionAnswered: (QuestionAnsweredEvent event) {},
  onSurveyClosed: (SurveyClosedEvent event) {},
  onSurveyCompleted: (SurveyCompletedEvent event) {},
);
SurvicateSdk.addSurvicateEventListener(listener);
SurvicateSdk.removeSurvicateEventListener(listener);

// Reset
SurvicateSdk.reset();
```

## Issues

Got an Issue?

To make things more streamlined, we’ve transitioned our issue reporting to our customer support platform. If you encounter any bugs or have feedback, please reach out to our customer support team. Your insights are invaluable to us, and we’re here to help ensure your experience is top-notch!

Contact us via Intercom in the application, or drop us an email at: [support@survicate.com]

Thank you for your support and understanding!
