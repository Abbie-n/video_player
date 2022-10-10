import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player_app/core/services/storage/offline_client.dart';

class OfflineClientImpl implements OfflineClient {
  static OfflineClient? _instance;
  static SharedPreferences? _preferences;

  static Future<OfflineClient> getInstance() async {
    _instance ??= OfflineClientImpl();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  @override
  String? getString(String key) {
    return _preferences?.getString(key);
  }

  @override
  Future setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  @override
  Future<bool?> clearData(String key) async {
    return await _preferences?.remove(key);
  }
}
