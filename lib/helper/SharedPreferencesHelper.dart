import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper{

  SharedPreferences prefs;

  SharedPreferencesHelper(){
    SharedPreferences.getInstance().then((sp) {
      this.prefs = sp;
    });
  }

  Future<Null> setUserEmail(String g) async {
    await this.prefs.setString('userEmail', g);
    print("Email saved");
  }
}