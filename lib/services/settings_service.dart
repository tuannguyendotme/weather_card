import 'package:flutter/foundation.dart';

import 'package:weather_card/models/settings_model.dart';
import 'package:weather_card/services/storage_service.dart';

class SettingsService with ChangeNotifier {
  StorageService storageService;
  Settings value;

  SettingsService(StorageService storageService) {
    this.storageService = storageService;
    value = storageService.loadSettings();
  }

  Future<void> saveUnit(String unit) async {
    final newSettings = value.copyWith(unit: unit);
    await storageService.saveSettings(newSettings);

    value = newSettings;
    notifyListeners();
  }
}
