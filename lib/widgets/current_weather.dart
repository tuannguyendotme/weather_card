import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

import 'package:weather_card/.env.dart';
import 'package:weather_card/helpers/ui_helper.dart';
import 'package:weather_card/services/current_weather_service.dart';
import 'package:weather_card/services/location_service.dart';
import 'package:weather_card/services/settings_service.dart';

class CurrentWeather extends StatelessWidget {
  final Function onRefresh;
  final Function onShowSettings;

  const CurrentWeather({
    @required this.onRefresh,
    @required this.onShowSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          Map(),
          Container(
            color: Color.fromARGB(50, 45, 55, 72),
          ),
          CurrentWeatherInfo(
            onRefresh: onRefresh,
            onShowSettings: onShowSettings,
          ),
        ],
      ),
    );
  }
}

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationService>(
      builder: (context, locationService, child) {
        final position = locationService.position;

        return FlutterMap(
          options: MapOptions(
            center: LatLng(position.latitude, position.longitude),
            zoom: 13.0,
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/t800t8/ck0hxusqi12if1cpdj034jsw6/tiles/256/{z}/{x}/{y}@2x?access_token=${Configuration.MapBoxApiKey}",
              additionalOptions: {
                'accessToken': Configuration.MapBoxApiKey,
                'id': 'mapbox.streets',
              },
            ),
          ],
        );
      },
    );
  }
}

class CurrentWeatherInfo extends StatelessWidget {
  final Function onRefresh;
  final Function onShowSettings;

  const CurrentWeatherInfo({
    @required this.onRefresh,
    @required this.onShowSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<CurrentWeatherService, SettingsService>(
      builder: (context, currentWeatherService, settingsService, child) {
        final currentWeather = currentWeatherService.value;

        return Container(
          padding: EdgeInsets.only(
            right: 16,
            top: 16,
            bottom: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      PopupMenuButton<String>(
                        icon: Icon(Icons.settings),
                        onSelected: (String choice) async {
                          switch (choice) {
                            case 'Refresh':
                              onRefresh();
                              break;

                            case 'Settings':
                              onShowSettings();
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                              value: 'Refresh',
                              child: const Text('Refresh'),
                            ),
                            PopupMenuItem<String>(
                              value: 'Settings',
                              child: const Text('Settings'),
                            ),
                          ];
                        },
                      ),
                      Text(
                        DateFormat('EEEEE').format(currentWeather.date),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          //color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    DateFormat('dd MMM yyyy').format(currentWeather.date),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      //color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.location_on),
                      Text(
                        currentWeather.location,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 28),
                    child: Icon(
                      UiHelper.getIconData(currentWeather.icon),
                      size: 70,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${currentWeather.temprature}°${settingsService.value.unit == 'metric' ? 'C' : 'F'}',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      //color: Colors.white,
                    ),
                  ),
                  Text(
                    currentWeather.description,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      //color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
