import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weather_card/services/current_weather_service.dart';
import 'package:weather_card/services/location_service.dart';
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
      body: FutureBuilder(
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
    );
  }
}
