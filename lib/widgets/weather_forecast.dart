import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:weather_card/helpers/ui_helper.dart';
import 'package:weather_card/services/settings_service.dart';
import 'package:weather_card/services/weather_forecast_service.dart';

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherForecastService>(
        builder: (context, weatherForecastService, child) {
      final currentItem = weatherForecastService.items[_currentIndex];

      return Container(
        padding: const EdgeInsets.all(20),
        color: const Color.fromARGB(255, 45, 55, 72),
        height: 320,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'PRESSURE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  currentItem.pressure.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'HUMIDITY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${currentItem.humidity}%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'WIND',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${currentItem.wind} Mph',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              width: 366,
              height: 140,
              child: Consumer<SettingsService>(
                builder: (context, settingsService, child) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: weatherForecastService.items.length,
                    itemBuilder: (context, index) {
                      final forecastItem = weatherForecastService.items[index];
                      final backgroundColor = _currentIndex == index
                          ? Colors.white
                          : Color.fromARGB(255, 26, 32, 44);
                      final foregroundColor =
                          _currentIndex == index ? Colors.black : Colors.white;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 86,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: backgroundColor,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    UiHelper.getIconData(forecastItem.icon),
                                    color: foregroundColor,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    DateFormat('EEE, hh a')
                                        .format(forecastItem.date),
                                    style: TextStyle(color: foregroundColor),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    '${forecastItem.temprature}°${settingsService.value.unit == 'metric' ? 'C' : 'F'}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: foregroundColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      );
    });
  }
}
