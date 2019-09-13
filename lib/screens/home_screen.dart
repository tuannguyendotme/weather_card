import 'package:flutter/material.dart';

import 'package:weather_card/widgets/four_days_forecast.dart';
import 'package:weather_card/widgets/today_weather.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TodayWeather(),
          FourDaysForecast(),
        ],
      ),
    );
  }
}
