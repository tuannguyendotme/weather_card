import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:weather_card/.env.dart';

class TodayWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          FlutterMap(
            options: MapOptions(
              center: LatLng(51.5, -0.09),
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
          ),
          Container(
            color: Color.fromARGB(60, 45, 55, 72),
          ),
          Container(
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
                          icon: Icon(Icons.more_vert),
                          onSelected: (String choice) async {},
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: 'ChangeLocation',
                                child: const Text('Change Location'),
                              ),
                              PopupMenuItem<String>(
                                value: 'Settings',
                                child: const Text('Settings'),
                              ),
                            ];
                          },
                        ),
                        Text(
                          'Wednesday',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            //color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '15 Jan 2019',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        //color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(Icons.location_on),
                        Text(
                          'Paris, FR',
                          style: TextStyle(
                            fontSize: 16,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.wb_cloudy,
                      size: 50,
                      //color: Colors.white,
                    ),
                    Text(
                      '-5°C',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        //color: Colors.white,
                      ),
                    ),
                    Text(
                      'Sunny',
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
          ),
        ],
      ),
    );
  }
}
