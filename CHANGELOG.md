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