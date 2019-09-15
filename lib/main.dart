import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_card/screens/home_screen.dart';
import 'package:weather_card/services/current_weather_service.dart';
import 'package:weather_card/services/weather_forecast_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CurrentWeatherService(),
        ),
        ChangeNotifierProvider.value(
          value: WeatherForecastService(),
        ),
      ],
      child: MaterialApp(
        title: 'Weather Card',
        home: HomeScreen(),
      ),
    );
  }
}
