import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:weather_card/.env.dart';
import 'package:weather_card/models/current_weather_model.dart';
import 'package:weather_card/services/settings_service.dart';

class CurrentWeatherService with ChangeNotifier {
  final SettingsService settingsService;
  CurrentWeatherModel value = CurrentWeatherModel.initial();

  CurrentWeatherService(this.settingsService);

  Future<void> fetch(double latitude, double longitude) async {
    final response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=${settingsService.value.unit}&appid=${Configuration.OpenWeatherApiKey}');
    final responseData = json.decode(response.body);

    value = CurrentWeatherModel.fromJson(responseData);

    notifyListeners();
  }
}
