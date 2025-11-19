
class WeatherModel {
  final String city;
  final String country;
  final double tempC;
  final double tempF;
  final String condition;
  final String conditionIcon;
  final double humidity;
  final double windKph;
  final List<ForecastDay> forecast;

  WeatherModel({
    required this.city,
    required this.country,
    required this.tempC,
    required this.tempF,
    required this.condition,
    required this.conditionIcon,
    required this.humidity,
    required this.windKph,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['location']['name'] ?? 'Unknown',
      country: json['location']['country'] ?? 'Unknown',
      tempC: (json['current']['temp_c'] ?? 0).toDouble(),
      tempF: (json['current']['temp_f'] ?? 0).toDouble(),
      condition: json['current']['condition']['text'] ?? 'Unknown',
      conditionIcon: 'https:${json['current']['condition']['icon']}',
      humidity: (json['current']['humidity'] ?? 0).toDouble(),
      windKph: (json['current']['wind_kph'] ?? 0).toDouble(),
      forecast: (json['forecast']['forecastday'] as List)
          .map((day) => ForecastDay.fromJson(day))
          .toList(),
    );
  }
}

class ForecastDay {
  final String date;
  final double maxTempC;
  final double minTempC;
  final String condition;
  final String conditionIcon;

  ForecastDay({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.condition,
    required this.conditionIcon,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date'] ?? '',
      maxTempC: (json['day']['maxtemp_c'] ?? 0).toDouble(),
      minTempC: (json['day']['mintemp_c'] ?? 0).toDouble(),
      condition: json['day']['condition']['text'] ?? 'Unknown',
      conditionIcon: 'https:${json['day']['condition']['icon']}',
    );
  }
}
