import 'dart:convert';
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
  Future setStringList(String key, List<String> value) async {
    await _preferences!.setStringList(key, value);
  }

  @override
  Future setMap(String key, Map<String, dynamic> map) async {
    String value = jsonEncode(map);
    await _preferences!.setString(key, value);
  }

  @override
  Future setList(String key, List<dynamic> map) async {
    String value = map.toString();
    await _preferences!.setString(key, value);
  }

  @override
  List<String>? getStringList(String key) {
    return _preferences?.getStringList(key);
  }

  @override
  Future<Map<String, dynamic>> getMap(String? key) {
    String? value = _preferences?.getString(key!);
    return json.decode(value!);
  }

  @override
  List<dynamic> getList(String key) {
    String? value = _preferences?.getString(key);
    return value as List<dynamic>;
  }

  @override
  Future<bool?> clearData(String key) async {
    return await _preferences?.remove(key);
  }

  @override
  Future<bool?> clearStorage() async {
    return await _preferences?.clear();
  }
}
