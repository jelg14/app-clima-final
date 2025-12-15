// lib/presentation/bloc/weather_bloc.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/weather_model.dart';
import '../../data/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _repository;

  WeatherBloc(this._repository) : super(const WeatherInitial()) {
    on<FetchWeatherEvent>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
    FetchWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoading());
    try {
      final weather = await _repository.fetchWeather(
        event.cityName,
        days: event.days,
      );
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(_handleError(e)));
    }
  }

  String _handleError(dynamic error) {
    final msg = error.toString();
    if (msg.contains('City not found')) return 'Ciudad no encontrada';
    if (msg.contains('Invalid API')) return 'API inválida';
    if (msg.contains('Timeout')) return 'Conexión agotada';
    return msg;
  }
}
