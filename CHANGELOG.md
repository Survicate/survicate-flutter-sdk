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