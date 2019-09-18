import 'package:flutter/foundation.dart';

class Settings {
  final String unit;

  Settings({@required this.unit});

  Settings copyWith({String unit}) {
    return Settings(unit: unit ?? this.unit);
  }
}
