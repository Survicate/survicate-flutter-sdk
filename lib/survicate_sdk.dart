import 'survicate_sdk_platform_interface.dart';

class SurvicateSdk {
  // Prevent instantiation of the class
  SurvicateSdk._();

  static void setWorkspaceKey(String workspaceKey) async {
    try {
      await SurvicateSdkPlatform.instance.setWorkspaceKey(workspaceKey);
    } catch (e) {
      // ignore
    }
  }

  static void initializeSdk() async {
    try {
      await SurvicateSdkPlatform.instance.initializeSdk();
    } catch (e) {
      // ignore
    }
  }

  static void invokeEvent(String eventName) async {
    try {
      await SurvicateSdkPlatform.instance.invokeEvent(eventName);
    } catch (e) {
      // ignore
    }
  }

  static void enterScreen(String screenName) async {
    try {
      await SurvicateSdkPlatform.instance.enterScreen(screenName);
    } catch (e) {
      // ignore
    }
  }

  static void leaveScreen(String screenName) async {
    try {
      await SurvicateSdkPlatform.instance.leaveScreen(screenName);
    } catch (e) {
      // ignore
    }
  }

  static void setUserId(String userId) async {
    try {
      await SurvicateSdkPlatform.instance.setUserId(userId);
    } catch (e) {
      // ignore
    }
  }

  static void setUserTrait(String key, String value) async {
    try {
      await SurvicateSdkPlatform.instance.setUserTrait(key, value);
    } catch (e) {
      // ignore
    }
  }

  static void reset() async {
    try {
      await SurvicateSdkPlatform.instance.reset();
    } catch (e) {
      // ignore
    }
  }
}
