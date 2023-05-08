import 'dart:convert';

import 'package:hive/hive.dart';

const secureStorageKey = "minh_fitness_app";
const boxName = "my_shared_preferences";

class SharedPreferences {
  static final shared = SharedPreferences();
  Box? box;

  Future<void> openHiveBox() async {
    box = await Hive.openBox(boxName);
  }

  setString(String key, String value) async {
    await box?.put(key, value);
  }

  String? getString(String key) {
    return box?.get(key);
  }

  setInt(String key, int val) async {
    await box?.put(key, val);
  }

  int? getInt(String key) {
    return box?.get(key);
  }

  setBool(String key, bool val) async {
    await box?.put(key, val);
  }

  bool? getBool(String key) {
    return box?.get(key);
  }

  setDouble(String key, double val) async {
    await box?.put(key, val);
  }

  double? getDouble(String key) {
    return box?.get(key);
  }

  deleteByKey(String key) async {
    box ?? await openHiveBox();
    await box!.delete(key);
  }

  delete() async {
    box ?? await openHiveBox();
    await box!.clear();
  }

  List<String> keys() {
    if (box != null) {
      return box!.keys.toList().map((e) => e.toString()).toList();
    }
    return [];
  }

  T? get<T, X>(String key, T Function(X) fromJson) {
    String? result = getString(key);
    if (result?.isEmpty ?? true) {
      return null;
    }
    return fromJson(jsonDecode(result!));
  }
}
