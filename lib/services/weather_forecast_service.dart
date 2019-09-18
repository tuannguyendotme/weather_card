import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:weather_card/.env.dart';
import 'package:weather_card/models/weather_forecast_model.dart';
import 'package:weather_card/services/settings_service.dart';

class WeatherForecastService with ChangeNotifier {
  final SettingsService settingsService;

  List<WeatherForecastModel> _items = [];

  WeatherForecastService(this.settingsService);

  UnmodifiableListView<WeatherForecastModel> get items =>
      UnmodifiableListView(_items);

  Future<void> fetch(double latitude, double longitude) async {
    final response = await http.get(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=${settingsService.value.unit}&appid=${Configuration.OpenWeatherApiKey}');
    final responseData = json.decode(response.body);

    for (var item in responseData['list']) {
      final forecastItem = WeatherForecastModel.fromJson(item);
      _items.add(forecastItem);
    }

    notifyListeners();
  }
}
