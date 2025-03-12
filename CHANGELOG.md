## 6.1.0
#### New
- You can add a disclaimer with or without a consent checkbox to all question types.

#### Improved
- Enhanced support for landscape orientation.

#### Updated
- Bumping up reference of Android to 6.1.0.
- Bumping up reference of iOS to 6.1.0.

#### Fixed
- The "has any value" logic condition in Matrix question now applies also to partial and empty answers.

## 6.0.0
### Android
#### Breaking
- SDK requires CompileSDK 34 or higher

### iOS
#### Breaking
- SDK requires minimum deployment target of iOS 14.

#### New
- Survey logic has been split into 2 types - Branch and Display logic.

  Branch logic includes all the previously available logic settings that allow you to select which question your respondents should see next based on their response to the current question.

  A new type of logic - Display logic - allows you to decide whether the current question should be shown or not based on the respondents’ answers to the questions earlier in the survey.

#### Improved
- Surveys are now displayed consecutively, if more than one survey meets the targeting criteria (instantly recurring surveys without event trigger will result in showing the survey in a loop).
- Improved animation on survey close and completion on Android.

#### Updated
- Bumping up reference of Android to 6.0.0.
- Bumping up reference of iOS to 6.0.0.

### iOS
#### Fixed
- An issue with answer selection in `shape` question

## 5.5.2
### Android
#### Fixed
- Fixed an issue with `getNetworkCapabilities` method that could occasionally cause exceptions during SDK initialization.

### iOS
#### Fixed
- Fixed a crash caused by non-thread-safe access to `localizedDescription` during error logging.

## 5.5.1
### iOS
#### Fixed
- Fixed an issue where comments were missing in event listeners.
- Fixed an issue where in Smiley Scale question in some cases the submit button was disabled.
- Fixed an issue with missing submit button in Multiple Answer question.
- Fixed an issue with missing comment field in CSAT question when answer is mandatory.

## 5.5.0
#### New
- You can now add a comment field to NPS, Smiley scale, Rating scale, Matrix, and Date question types. There is also a comment title available for all comment fields. You can use it to ask a question and give your respondents some context of what you would like to see in the comment.

### Android
#### Updated
- AndroidX Annotation to 1.9.1
- Coroutines Android to 1.9.0

## 5.4.0
#### New
- Each question type except Welcome message, Date, and Thank you screen can be set as mandatory or optional.

#### Improved
- Accessibility features for Matrix question, survey progress indicator, and navigation buttons.

## 5.3.0
#### New
- Once an event is invoked in the app, its name and property names are also sent to Survicate’s panel now. They will be shown as suggestions when a user configures event targeting of a survey.

## 5.2.0
#### New
- New conditions are available in event targeting:
    - Time delay after event occurrence.
    - Number of event occurrences.
    - Time of the first occurrence.
    - Time of the last occurrence.
If multiple conditions are applied, all of them should be met for a survey to appear.

#### Updated
- Bumping up reference of Android to 5.2.0.
- Bumping up reference of iOS to 5.2.0.

### iOS
#### Fixed 
- Fixed an issue with submit button visibility in single choice question.
  
## 5.1.1
#### Updated
- Bumping up reference of Android to 5.1.1.
- Bumping up reference of iOS to 5.1.2.
  
#### Improved
- More distinguishable emojis in the 3-choice Smiley scale.

### Android
#### Fixed
- Excessive spacing between Smiley scale emojis in the 3-choice layout.
- Back button icon color on dark backgrounds.
- An issue where "Submit" was displayed instead of "Start Survey" on the welcome CTA point after navigating back to it.

### iOS
#### Fixed 
- Excessive spacing between Smiley scale emojis in the 3-choice layout.
- Issue on iOS with non visible Submit button in multiple choice questions.

## 5.1.0
#### New
- Navigation buttons are available now. When enabled, your survey respondents can go back to the previous questions, see their selected answers, and change them if necessary.

#### Updated
- Bumping up reference of Android to 5.1.0.
- Bumping up reference of iOS to 5.1.1.

### Android
#### Improved
- Higher resolution of Smiley scale icons.

### Android
#### Fixed
- Propagating Matrix answer in `SurvicateAnswer.value` of event listener.
- An issue that resulted in unexpected vertical padding for Matrix question in full screen mode.

### iOS
#### Fixed 
- Propagating Matrix answer in `SurvicateAnswer.value` of event listener.
- Configuration json will be printed in console only in verbose log level.

## 5.0.0
#### New
- Matrix question type added.

#### Updated
- Bumping up reference of Android to 5.0.0.
- Bumping up reference of iOS to 5.0.0.

### Android
#### Fixed
- UI state bugs related to Activity's configuration changes.
- Animation resource names that could conflict with resources of the app or other libraries on Android.

### iOS
#### Fixed
- An issue where `setUserTraits` cleared previously set user traits.

## 4.4.0
#### New
- New targeting option available - event properties. You can add multiple properties to one event and join them with either “or” or “and” operator. Property names and values are case-sensitive. Only string values are supported.

#### Updated
- Bumping up reference of Android to 4.4.0.
- Bumping up reference of iOS to 4.4.0.

### Android
#### Fixed
- A bug that could prevent a survey from being displayed if a delay was set for multiple screens in the panel.
- Horizontal mode support for Numerical Rating question for up to 5 items.
  
## 4.3.0
#### New
- More flexible survey recurring options are available now. Now you can specify how many days / weeks / months / years should pass before the survey can appear again. It’s also possible to set after how many days / weeks / months / years the survey should stop recurring.
- If you run several mobile surveys, now you can use survey throttling settings to specify a time frame that should pass between showing them. Use global throttling to set the same time frame for all your mobile surveys. Or use the survey level throttling to override the global settings and specify a different period before showing a particular survey.

#### Updated
- Bumping up reference of Android to 4.3.0.
- Bumping up reference of iOS to 4.3.0.

### iOS
#### Fixed
- Issue with recursive display of non-recurring survey.
 
## 4.2.0
#### New
- New targeting filter is available - screen orientation (portrait mode or landscape mode targeting). You can either include or exclude one of the orientation modes.

#### Updated
- Bumping up reference of Android to 4.2.0.
- Bumping up reference of iOS to 4.2.0.

### Android
#### Improved
- Performance enhancements in answers synchronization.

#### Fixed
- An issue where SurveyActivity could crash when it was restored after process termination.
- A race condition in the recalling feature.

## 4.0.1
#### Updated
- Bumping up reference of Android to 4.0.2.
- Bumping up reference of iOS to 4.0.2.

#### Improved
- Date format in user traits recalling

### iOS
#### Fixed
- A bug where users could see survey more times than specified in recurrence settings if SDK was updated in meantime
- An issue where Thank you screen don't close survey in classic theme in iOS

### Android
#### Fixed
- A bug where users could see survey more times than specified in recurrence settings if SDK was updated in meantime
- Sending user attributes to backend only when necessary in Android

## 4.0.0
#### New
- User conditions targeting is changed to the audience targeting: create an audience that will be available for usage among all your mobile surveys. Enable multiple audiences at the same time in one survey if necessary.
- User attributes now support not only string values but also numbers, boolean, and datetime values.
- New attribute operators are available to support new data types.
- Survey audience can be set not only by including a set of respondents who met the required criteria but also by excluding those who should not see the survey.
- And / or operators in audience targeting are switchable now: within one attribute filter that has several attributes in it and between different filters.
 
#### Breaking
- Method `setUserTrait` now takes single `UserTrait` argument instead of two String arguments.
- Method `setUserTraits` now takes `List<UserTrait>` argument instead of `Map<String, String>` argument.

### Android
#### Updated
- Bumping up reference of Android to 4.0.1.
- Use `NetworkCapabilities` to check internet connection (API 24+).
- Migrate to `WindowCompat` APIs for setting full screen background.

#### Fixed
- Fixed invalid survey closing when app has specified `android:enableOnBackInvokedCallback="true"` in the AndroidManifest.xml.

### iOS
#### Updated
- Bumping up reference of iOS to 4.0.0.

## 3.0.5
### Android
#### Updated
- Survicate Android SDK to 3.0.6.
- AGP to 8.1.2
- Kotlin to 1.9.10
- AndroidX RecyclerView to 1.3.2
- Creating User Trait requires non null key.
- Added a Proguard rule for User Traits.
#### Fixed
- An issue with saving User Traits that could cause crash whenever saved User Trait key was null.
- An issue where answers saved without internet were not synchronized in next app sessions.
- An issue with javadoc generation.

## 3.0.4
### iOS
#### Fixed
- Issue where surveys were not translated when app language was set to dialect.
- Issue where rating scale question answer ID was missing in listener.

### Android
#### Fixed
- Added image scaling to shapes rating questions to fit all answers on the screen in horizontal layout.
- Issue on Thank You question with button's title not using text from survey settings.
- Issue where in some cases survey was not dismissible.

## 3.0.2

### New
- First version of the SDK, with references to the native Survicate SDKs version 3.0.2