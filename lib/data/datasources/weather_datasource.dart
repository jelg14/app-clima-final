// lib/data/datasources/weather_datasource.dart

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weather_model.dart';

class WeatherDataSource {
  static const String _baseUrl = 'https://api.weatherapi.com/v1';
  static const String _apiKey = 'e0a2fe21291148cc9b6221836251511';

  final http.Client httpClient;

  WeatherDataSource({required this.httpClient});

  Future<WeatherModel> getWeather(String city, int days) async {
    try {
      final encodedCity = Uri.encodeComponent(city.trim());
      final url = Uri.parse(
        '$_baseUrl/forecast.json?key=$_apiKey&q=$encodedCity&days=$days&aqi=no',
      );

      final response = await httpClient.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Tiempo de conexión agotado');
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return WeatherModel.fromJson(json);
      } else if (response.statusCode == 400) {
        throw Exception('Ciudad no encontrada');
      } else if (response.statusCode == 403) {
        throw Exception('API Key inválida');
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Sin conexión a internet');
    } catch (e) {
      rethrow;
    }
  }
}
