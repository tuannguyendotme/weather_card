import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_card/models/settings_model.dart';

class StorageService {
  static final String _unitKey = 'unit';
  static final String _defaultUnit = 'metric';

  final SharedPreferences prefs;

  StorageService(this.prefs);

  Settings loadSettings() {
    return Settings(
      unit: prefs.containsKey(_unitKey)
          ? prefs.getString(_unitKey)
          : _defaultUnit,
    );
  }

  Future<void> saveSettings(Settings settings) async {
    await prefs.setString(_unitKey, settings.unit);
  }
}
