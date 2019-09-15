import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:weather_card/.env.dart';
import 'package:weather_card/models/weather_forecast_model.dart';

class WeatherForecastService with ChangeNotifier {
  List<WeatherForecastModel> _items = [];

  UnmodifiableListView<WeatherForecastModel> get items =>
      UnmodifiableListView(_items);

  Future<void> fetch() async {
    final response = await http.get(
        'https://api.openweathermap.org/data/2.5/forecast?q=Hanoi&units=metric&appid=${Configuration.OpenWeatherApiKey}');
    final responseData = json.decode(response.body);

    for (var item in responseData['list']) {
      print(item);

      final forecastItem = WeatherForecastModel.fromJson(item);
      _items.add(forecastItem);
    }

    notifyListeners();
  }
}
