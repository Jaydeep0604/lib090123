

import 'package:shared_preferences/shared_preferences.dart';

class GlobalData{
  static final GlobalData _instance = GlobalData._internal();

  factory GlobalData() {
    return _instance;
  }

  GlobalData._internal() {
    // initialization logic
  }

  int userId = 0;
  String firstName = '';
  String lastName = '';

  Future<void> retrieveLoggedInUserDetail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getInt('app_user_id') ?? 0 ;
    firstName = pref.getString('first_name') ?? '' ;
    lastName = pref.getString('last_name') ?? '' ;
  }
}