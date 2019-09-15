class CurrentWeatherModel {
  final DateTime date = DateTime.now();
  final int temprature;
  final String icon;
  final String description;
  final String location;

  CurrentWeatherModel(
    this.temprature,
    this.icon,
    this.description,
    this.location,
  );

  CurrentWeatherModel.initial()
      : temprature = 0,
        icon = '',
        description = '',
        location = '';

  CurrentWeatherModel.fromJson(Map<String, dynamic> json)
      : temprature = double.parse(json['main']['temp'].toString()).toInt(),
        icon = json['weather'][0]['icon'],
        description = json['weather'][0]['main'],
        location = '${json['name']}, ${json['sys']['country']}';
}
