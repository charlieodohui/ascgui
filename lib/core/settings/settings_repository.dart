import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  const Settings({this.adbPath, this.scrcpyPath});
  final String? adbPath;
  final String? scrcpyPath;

  Settings copyWith({String? adbPath, String? scrcpyPath}) => Settings(
    adbPath: adbPath ?? this.adbPath,
    scrcpyPath: scrcpyPath ?? this.scrcpyPath,
  );
}

class SettingsRepository {
  SettingsRepository(this._prefs);
  final SharedPreferences _prefs;

  Settings load() => Settings(
    adbPath: _prefs.getString('adbPath'),
    scrcpyPath: _prefs.getString('scrcpyPath'),
  );

  Future<void> save(Settings s) async {
    Future<void> put(String key, String? value) async {
      if (value == null || value.isEmpty) {
        await _prefs.remove(key);
      } else {
        await _prefs.setString(key, value);
      }
    }

    await put('adbPath', s.adbPath);
    await put('scrcpyPath', s.scrcpyPath);
  }
}