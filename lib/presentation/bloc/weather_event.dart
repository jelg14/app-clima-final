// lib/presentation/bloc/weather_event.dart

part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  final String cityName;
  final int days;

  const FetchWeatherEvent(this.cityName, {this.days = 7});

  @override
  List<Object> get props => [cityName, days];
}
