class WeatherForecastModel {
  final DateTime date;
  final int temprature;
  final int tempratureMax;
  final int tempratureMin;
  final String icon;
  final double pressure;
  final int humidity;
  final double wind;

  WeatherForecastModel(
    this.date,
    this.temprature,
    this.tempratureMax,
    this.tempratureMin,
    this.icon,
    this.pressure,
    this.humidity,
    this.wind,
  );

  WeatherForecastModel.initial()
      : date = null,
        temprature = 0,
        tempratureMax = 0,
        tempratureMin = 0,
        icon = '',
        pressure = 0,
        humidity = 0,
        wind = 0;

  WeatherForecastModel.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json['dt_txt']),
        temprature = double.parse(json['main']['temp'].toString()).toInt(),
        tempratureMax =
            double.parse(json['main']['temp_max'].toString()).toInt(),
        tempratureMin =
            double.parse(json['main']['temp_min'].toString()).toInt(),
        icon = json['weather'][0]['icon'],
        pressure = double.parse(json['main']['pressure'].toString()),
        humidity = json['main']['humidity'],
        wind = double.parse(json['wind']['speed'].toString());
}
