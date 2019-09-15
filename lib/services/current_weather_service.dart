import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:weather_card/.env.dart';
import 'package:weather_card/models/current_weather_model.dart';

class CurrentWeatherService with ChangeNotifier {
  CurrentWeatherModel value = CurrentWeatherModel.initial();

  Future<void> fetch() async {
    final response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=Hanoi&units=metric&appid=${Configuration.OpenWeatherApiKey}');
    final responseData = json.decode(response.body);

    value = CurrentWeatherModel.fromJson(responseData);

    print(value.date);

    notifyListeners();
  }
}
