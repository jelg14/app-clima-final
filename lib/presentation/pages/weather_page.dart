import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/weather_card.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(
          const FetchWeatherEvent('Guatemala'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF007ACC),
        scaffoldBackgroundColor: const Color(0xFF1E1E1E), 
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF007ACC),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
          headlineMedium: TextStyle(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF252526),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.white54),
          suffixIconColor: Colors.white,
        ),
        cardColor: const Color(0xFF252526),
        iconTheme: const IconThemeData(color: Colors.white70),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('🌤️ Pronóstico del Clima'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Ingresa una ciudad...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        context.read<WeatherBloc>().add(
                              FetchWeatherEvent(_controller.text),
                            );
                        _controller.clear();
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherInitial) {
                    return const Center(
                      child: Text('Busca una ciudad'),
                    );
                  } else if (state is WeatherLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WeatherLoaded) {
                    return ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        WeatherCard(weather: state.weather),
                        const SizedBox(height: 20),
                        const Text(
                          'Pronóstico de 10 días',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...state.weather.forecast.take(10).map(
                              (day) => Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            day.date,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            day.condition,
                                            style: const TextStyle(
                                                color: Colors.white70),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${day.maxTempC}°C - ${day.minTempC}°C',
                                        style:
                                            const TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                      ],
                    );
                  } else if (state is WeatherError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error,
                            size: 64,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(state.message,
                                  style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
