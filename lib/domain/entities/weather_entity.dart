// lib/domain/entities/weather_entity.dart

import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String city;
  final double tempC;
  final String condition;
  
  const WeatherEntity({
    required this.city,
    required this.tempC,
    required this.condition,
  });

  @override
  List<Object?> get props => [city, tempC, condition];
}
