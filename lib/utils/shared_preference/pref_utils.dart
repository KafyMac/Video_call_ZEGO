import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  SharedPreferences? _preferences;

//initialising the share pref
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //storing logged in user

  String loggedIn = 'loggedIn';

  static const String tokenKey = 'userToken';

  void setUserLog(bool isLoggedin) async {
    await init();
    _preferences!.setBool(loggedIn, isLoggedin);
  }

  Future<bool> getUserLog() async {
    await init();
    return _preferences!.getBool(loggedIn) ?? false;
  }

  Future<void> saveUserToken(String token) async {
    await init();
    _preferences!.setString(tokenKey, token);
  }

  Future<String?> getUserToken() async {
    await init();
    return _preferences!.getString(tokenKey);
  }
}
