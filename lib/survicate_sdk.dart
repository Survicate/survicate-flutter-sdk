import 'survicate_sdk_platform_interface.dart';

class SurvicateSdk {
  // Prevent instantiation of the class
  SurvicateSdk._();

  /// Sets workspace key to be used in SDK. Must be called before [initializeSdk] is called.
  ///
  /// The [key] parameter represents the workspace key.
  static void setWorkspaceKey(String workspaceKey) async {
    try {
      await SurvicateSdkPlatform.instance.setWorkspaceKey(workspaceKey);
    } catch (e) {
      // ignore
    }
  }

  /// Initializes the SDK. This method has to be called prior to any other calls to the SDK.
  static void initializeSdk() async {
    try {
      await SurvicateSdkPlatform.instance.initializeSdk();
    } catch (e) {
      // ignore
    }
  }

  /// Invoke a fire-and-forget event which can be used for targeting, e.g. client can choose to
  /// show the survey only when an "add_to_basket" button is clicked.
  ///
  /// [eventName] An arbitrary event name.
  static void invokeEvent(String eventName) async {
    try {
      await SurvicateSdkPlatform.instance.invokeEvent(eventName);
    } catch (e) {
      // ignore
    }
  }

  /// Client can use this method to mark an event of a user entering a screen. It is used by the SDK
  /// for survey targeting. For example, the client can choose to show the survey only to users
  /// who have entered a "Cart" screen and spent 4 seconds there.
  ///
  /// [screenName] represents an arbitrary screen name and serves as the key to recognize
  /// the screen when [leaveScreen] is invoked.
  ///
  /// See also:
  ///  * [leaveScreen], the corresponding method to mark when a user exits a screen.
  static void enterScreen(String screenName) async {
    try {
      await SurvicateSdkPlatform.instance.enterScreen(screenName);
    } catch (e) {
      // ignore
    }
  }

  /// Client can use this method to mark an event of a user leaving a screen. It is used by the SDK
  /// for survey targeting. When the client invoked [enterScreen] earlier, he can inform the SDK's
  /// targeting engine that the user is no longer on this specific screen.
  ///
  /// [screenName] is the screen name used previously in the [enterScreen] method.
  ///
  /// See also:
  ///  * [enterScreen], the method used to mark when a user enters a screen.
  static void leaveScreen(String screenName) async {
    try {
      await SurvicateSdkPlatform.instance.leaveScreen(screenName);
    } catch (e) {
      // ignore
    }
  }

  /// Shorthand version of [setUserTraits].
  static void setUserTrait(String key, String value) async {
    try {
      await SurvicateSdkPlatform.instance.setUserTrait(key, value);
    } catch (e) {
      // ignore
    }
  }

  /// Through this method, clients can provide traits of the user.
  /// These can be arbitrary key-value pairs. Traits are persisted, so the client only needs to
  /// provide them once. Traits are sent to the system along with the user's answers to the survey. They
  /// are also used for targeting (e.g., a client can choose to show the survey to just
  /// users with `eyes_color=blue` in the Survicate Panel).
  ///
  /// To change a trait, clients need to send the same key with a different value.
  static void setUserTraits(Map<String, String> traits) async {
    try {
      await SurvicateSdkPlatform.instance.setUserTraits(traits);
    } catch (e) {
      // ignore
    }
  }

  /// Removes all the data stored in SDK, e.g. all the previously loaded surveys, user traits,
  /// saved but unsynchronised answers etc., then loads the surveys from the backend again.
  ///
  /// The primary use of this method is to reset the information that a survey has been
  /// already seen by the user. Normally, a user can only see a survey once, which can
  /// be problematic when debugging. That's why it's useful to reset the SDK so that
  /// a survey can be seen again.
  static void reset() async {
    try {
      await SurvicateSdkPlatform.instance.reset();
    } catch (e) {
      // ignore
    }
  }
}
