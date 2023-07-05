import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/utils/my_strings.dart';

abstract class RevisionService {
  static Future<int> get() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getInt(MyStrings.revision) ?? 0;
  }

  static Future<bool> set(int revision) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setInt(MyStrings.revision, revision);
  }
}
