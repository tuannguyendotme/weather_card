import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weather_card/services/current_weather_service.dart';
import 'package:weather_card/services/weather_forecast_service.dart';

import 'package:weather_card/widgets/four_days_forecast.dart';
import 'package:weather_card/widgets/current_weather.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future _initialLoad;

  @override
  void initState() {
    super.initState();

    final currentWeatherService =
        Provider.of<CurrentWeatherService>(context, listen: false);
    final weatherForecastService =
        Provider.of<WeatherForecastService>(context, listen: false);

    final List<Future> futures = [];
    futures.add(currentWeatherService.fetch());
    futures.add(weatherForecastService.fetch());

    _initialLoad = Future.wait(futures);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initialLoad,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.done:
              return Column(
                children: <Widget>[
                  CurrentWeather(),
                  FourDaysForecast(),
                ],
              );

            default:
              return Center(
                child: Text('Something went wrong.'),
              );
          }
        },
      ),
    );
  }
}
