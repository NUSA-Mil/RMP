import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'movie.dart';

class StorageService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieAdapter());
    await Hive.openBox<Movie>('movies');
  }

  static Future<void> setTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
  }

  static Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark') ?? false;
  }
}