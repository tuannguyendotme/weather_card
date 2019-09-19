import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weather_card/services/current_weather_service.dart';
import 'package:weather_card/services/location_service.dart';
import 'package:weather_card/services/settings_service.dart';
import 'package:weather_card/services/weather_forecast_service.dart';
import 'package:weather_card/widgets/weather_forecast.dart';
import 'package:weather_card/widgets/current_weather.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future load(BuildContext context) async {
    final locationService =
        Provider.of<LocationService>(context, listen: false);
    final currentWeatherService =
        Provider.of<CurrentWeatherService>(context, listen: false);
    final weatherForecastService =
        Provider.of<WeatherForecastService>(context, listen: false);
    final position = await locationService.getCurrentPosition();
    final List<Future> futures = [];

    futures.add(
        weatherForecastService.fetch(position.latitude, position.longitude));
    futures.add(
        currentWeatherService.fetch(position.latitude, position.longitude));

    return Future.wait(futures);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SettingsService>(
        builder: (context, settingsService, child) => FutureBuilder(
          future: load(context),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );

              case ConnectionState.done:
                return Column(
                  children: <Widget>[
                    CurrentWeather(
                      onRefresh: () {
                        setState(() {});
                      },
                      onShowSettings: showSettings,
                    ),
                    WeatherForecast(),
                  ],
                );

              default:
                return Center(
                  child: Text('Something went wrong.'),
                );
            }
          },
        ),
      ),
    );
  }

  void showSettings() {
    final settingsService =
        Provider.of<SettingsService>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: const Color.fromARGB(255, 21, 25, 33),
        height: 200,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Unit',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Celsius",
                      ),
                      Radio(
                        value: 'metric',
                        groupValue: settingsService.value.unit,
                        onChanged: (value) {
                          settingsService.saveUnit(value);
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Fahrenheit",
                      ),
                      Radio(
                        value: 'imperial',
                        groupValue: settingsService.value.unit,
                        onChanged: (value) {
                          settingsService.saveUnit(value);
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
