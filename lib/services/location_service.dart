import 'package:flutter/foundation.dart';

import 'package:geolocator/geolocator.dart';

class LocationService with ChangeNotifier {
  final Geolocator _geolocator = Geolocator();
  Position position;

  Future<Position> getCurrentPosition() async {
    position = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    notifyListeners();

    return position;
  }
}
