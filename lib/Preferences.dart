import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future<bool> saveSession(int ?type, String? name, String? dept) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt("type", type!);
    await sharedPreferences.setString("name", name!);
    return await sharedPreferences.setString("dept", dept!);
  }
}