import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weather_card/screens/home_screen.dart';
import 'package:weather_card/services/current_weather_service.dart';
import 'package:weather_card/services/location_service.dart';
import 'package:weather_card/services/settings_service.dart';
import 'package:weather_card/services/storage_service.dart';
import 'package:weather_card/services/weather_forecast_service.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp(this.prefs);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(
          value: StorageService(prefs),
        ),
        ChangeNotifierProvider.value(
          value: LocationService(),
        ),
        ChangeNotifierProxyProvider<StorageService, SettingsService>(
          initialBuilder: null,
          builder: (context, storageService, settingsService) {
            settingsService = SettingsService(storageService);

            return settingsService;
          },
        ),
        ChangeNotifierProxyProvider<SettingsService, CurrentWeatherService>(
          initialBuilder: null,
          builder: (context, settingsService, currentWeatherService) {
            currentWeatherService = CurrentWeatherService(settingsService);

            return currentWeatherService;
          },
        ),
        ChangeNotifierProxyProvider<SettingsService, WeatherForecastService>(
          initialBuilder: null,
          builder: (context, settingsService, weatherForecastService) {
            weatherForecastService = WeatherForecastService(settingsService);

            return weatherForecastService;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Weather Card',
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
