abstract class OfflineClient {
  Future setStringList(String key, List<String> value);

  Future setMap(String key, Map<String, dynamic> map);

  Future setList(String key, List<dynamic> map);

  List<String>? getStringList(String key);

  Future<Map<String, dynamic>> getMap(String? key);

  List<dynamic> getList(String key);

  Future<bool?> clearData(String key);

  Future<bool?> clearStorage();
}
