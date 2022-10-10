abstract class OfflineClient {
  Future setString(String key, String value);
  String? getString(String key);

  Future<bool?> clearData(String key);
}
