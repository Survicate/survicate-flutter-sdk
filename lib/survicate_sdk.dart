import 'package:survicate_sdk/survicate_sdk_event_listener.dart';
import 'package:survicate_sdk/survicate_sdk_integrations.dart';
import 'package:survicate_sdk/user_trait.dart';

import 'survicate_sdk_platform_interface.dart';

export 'survicate_sdk_event_listener.dart';
export 'survicate_sdk_event_models.dart';
export 'survicate_sdk_integrations.dart';

class SurvicateSdk {
  // Prevent instantiation of the class
  SurvicateSdk._();

  /// The [integrations] object provides access to the extended methods of the SDK
  /// for integrations with other services.
  static Integrations integrations = Integrations();

  /// Sets workspace key to be used in SDK. Must be called before [initializeSdk] is called.
  ///
  /// The [workspaceKey] parameter represents the workspace key.
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
  /// [eventProperties] An arbitrary event properties.
  static void invokeEvent(String eventName,
      {Map<String, String> eventProperties = const {}}) async {
    try {
      await SurvicateSdkPlatform.instance
          .invokeEvent(eventName, eventProperties);
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

  /// Sets a single [trait] for the user, identified by [trait.key], with the provided [trait.value].
  /// These can be arbitrary key-value pairs. Traits are persisted, so the client
  /// only needs to provide them once. Traits are sent to the system along
  /// with the user's answers to the survey. They are also used for targeting (e.g., a client
  /// can choose to show the survey to just users with `eyes_color=blue` in the Survicate Panel).
  ///
  /// To change a trait, clients need to send the same key with a different value.
  /// See also:
  ///  * [setUserTraits], the method used to set multiple traits at once.
  static void setUserTrait(UserTrait trait) async {
    try {
      await SurvicateSdkPlatform.instance.setUserTrait(trait.key, trait.value);
    } catch (e) {
      // ignore
    }
  }

  /// Sets multiple user traits at once using the provided [traits] list.
  /// See also:
  ///  * [setUserTrait], the method used to set a single trait.
  static void setUserTraits(List<UserTrait> traits) async {
    try {
      Map<String, String> userTraits = {};
      for (var element in traits) {
        userTraits[element.key] = element.value;
      }
      await SurvicateSdkPlatform.instance.setUserTraits(userTraits);
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

  /// Client can use this method to add event listener, e.g. to trigger certain actions
  /// in application based on the visitor's actions.
  ///
  /// @param listener Event listener to add.
  static void addSurvicateEventListener(
      SurvicateEventListenerInterface listener) {
    SurvicateSdkPlatform.instance.addSurvicateEventListener(listener);
  }

  /// Client can use this method to remove an event listener added previously by the [addSurvicateEventListener].
  ///
  /// @param listener Event listener to remove.
  static void removeSurvicateEventListener(
      SurvicateEventListenerInterface listener) {
    SurvicateSdkPlatform.instance.removeSurvicateEventListener(listener);
  }

  /// Sets the preferred locale used for survey translations and targeting filters.
  /// The specified locale takes priority over the device's default locale.
  ///
  /// This method affects only the Survicate SDK and does not change in any way the app locale settings.
  ///
  /// [languageTag] An IETF language tag such as:
  ///   - Two-letter ISO 639 language code (e.g., "en", "fr")
  ///   - Three-letter ISO 639 language code for languages without the two-letter code (e.g., "haw", "yue")
  ///   - Language with region (e.g., "en-US", "pt-BR")
  ///   - Language with script (e.g., "zh-Hans")
  static void setLocale(String languageTag) async {
    try {
      await SurvicateSdkPlatform.instance.setLocale(languageTag);
    } catch (e) {
      // ignore
    }
  }
}
