import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

import 'package:weather_card/.env.dart';
import 'package:weather_card/models/current_weather_model.dart';
import 'package:weather_card/services/current_weather_service.dart';

class CurrentWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          Map(),
          Container(
            color: Color.fromARGB(50, 45, 55, 72),
          ),
          CurrentWeatherInfo(),
        ],
      ),
    );
  }
}

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
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
    );
  }
}

class CurrentWeatherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentWeatherService>(
      builder: (context, currentWeatherService, child) {
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
                        onSelected: (String choice) async {},
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
                      // IconButton(
                      //   icon: Icon(Icons.settings),
                      //   onPressed: () {},
                      // ),
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
                      currentWeather.getIconData(),
                      size: 70,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${currentWeather.temprature}°C',
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

    // return Container(
    //   padding: EdgeInsets.only(
    //     right: 16,
    //     top: 16,
    //     bottom: 16,
    //   ),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     crossAxisAlignment: CrossAxisAlignment.end,
    //     children: <Widget>[
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         children: <Widget>[
    //           SizedBox(
    //             height: 30,
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: <Widget>[
    //               // PopupMenuButton<String>(
    //               //   icon: Icon(Icons.more_vert),
    //               //   onSelected: (String choice) async {},
    //               //   itemBuilder: (BuildContext context) {
    //               //     return [
    //               //       PopupMenuItem<String>(
    //               //         value: 'ChangeLocation',
    //               //         child: const Text('Change Location'),
    //               //       ),
    //               //       PopupMenuItem<String>(
    //               //         value: 'Settings',
    //               //         child: const Text('Settings'),
    //               //       ),
    //               //     ];
    //               //   },
    //               // ),
    //               IconButton(
    //                 icon: Icon(Icons.settings),
    //                 onPressed: () {},
    //               ),
    //               Text(
    //                 'Wednesday',
    //                 style: TextStyle(
    //                   fontSize: 30,
    //                   fontWeight: FontWeight.bold,
    //                   //color: Colors.blueGrey,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Text(
    //             '15 Jan 2019',
    //             style: TextStyle(
    //               fontWeight: FontWeight.bold,
    //               fontSize: 18,
    //               //color: Colors.white,
    //             ),
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: <Widget>[
    //               Icon(Icons.location_on),
    //               Text(
    //                 'Paris, FR',
    //                 style: TextStyle(
    //                   fontSize: 16,
    //                   //color: Colors.white,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         children: <Widget>[
    //           Icon(
    //             Icons.wb_cloudy,
    //             size: 50,
    //             //color: Colors.white,
    //           ),
    //           Text(
    //             '-5°C',
    //             style: TextStyle(
    //               fontSize: 48,
    //               fontWeight: FontWeight.bold,
    //               //color: Colors.white,
    //             ),
    //           ),
    //           Text(
    //             'Sunny',
    //             style: TextStyle(
    //               fontSize: 26,
    //               fontWeight: FontWeight.bold,
    //               //color: Colors.white,
    //             ),
    //           ),
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}
