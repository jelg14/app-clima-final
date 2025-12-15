

import '../datasources/weather_datasource.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  final WeatherDataSource _dataSource;

  WeatherRepository(this._dataSource);

  Future<WeatherModel> fetchWeather(String city, {int days = 7}) async {
    return await _dataSource.getWeather(city, days);
  }
}
