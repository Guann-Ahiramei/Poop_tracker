import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/poop_entry.dart';

class PoopStorage {
  static const String _key = 'poop_entries';

  Future<void> save(List<PoopEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = entries.map((e) => e.toJson()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }

  Future<List<PoopEntry>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json == null) return [];
    final List data = jsonDecode(json);
    return data.map((e) => PoopEntry.fromJson(e)).toList();
  }
}
