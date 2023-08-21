import 'survicate_sdk_platform_interface.dart';

class SurvicateSdk {
  void setWorkspaceKey(String workspaceKey) async {
    try {
      await SurvicateSdkPlatform.instance.setWorkspaceKey(workspaceKey);
    } catch (e) {
      // ignore
    }
  }

  void initializeSdk() async {
    try {
      await SurvicateSdkPlatform.instance.initializeSdk();
    } catch (e) {
      // ignore
    }
  }

  void invokeEvent(String eventName) async {
    try {
      await SurvicateSdkPlatform.instance.invokeEvent(eventName);
    } catch (e) {
      // ignore
    }
  }

  void enterScreen(String screenName) async {
    try {
      await SurvicateSdkPlatform.instance.enterScreen(screenName);
    } catch (e) {
      // ignore
    }
  }

  void leaveScreen(String screenName) async {
    try {
      await SurvicateSdkPlatform.instance.leaveScreen(screenName);
    } catch (e) {
      // ignore
    }
  }

  void setUserId(String userId) async {
    try {
      await SurvicateSdkPlatform.instance.setUserId(userId);
    } catch (e) {
      // ignore
    }
  }

  void setUserTrait(String key, String value) async {
    try {
      await SurvicateSdkPlatform.instance.setUserTrait(key, value);
    } catch (e) {
      // ignore
    }
  }

  void reset() async {
    try {
      await SurvicateSdkPlatform.instance.reset();
    } catch (e) {
      // ignore
    }
  }
}
