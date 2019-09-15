import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:weather_card/helpers/ui_helper.dart';
import 'package:weather_card/services/weather_forecast_service.dart';

class WeatherForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherForecastService>(
      builder: (context, weatherForecastService, child) => Container(
        padding: EdgeInsets.all(20),
        color: Color.fromARGB(255, 45, 55, 72),
        height: 320,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'PRESURE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '10',
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
                  '29%',
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
                  '12 Mph',
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
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: weatherForecastService.items.length,
                  itemBuilder: (context, index) {
                    final forecastItem = weatherForecastService.items[index];

                    return Row(
                      children: <Widget>[
                        Container(
                          width: 86,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(UiHelper.getIconData(forecastItem.icon)),
                              SizedBox(height: 10),
                              Text(DateFormat('EEE, hh a')
                                  .format(forecastItem.date)),
                              SizedBox(height: 6),
                              Text(
                                '${forecastItem.temprature}°C',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
