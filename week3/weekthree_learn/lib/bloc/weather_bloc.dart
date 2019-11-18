import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blocklearn/data/weather_repository.dart';
import 'package:blocklearn/bloc/bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository);

  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    yield WeatherLoading();
    if(event is GetWeather) {
      try {
        final _weather = await weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoaded(_weather);
      } on NetworkError {
        yield WeatherError('Couldn\'t fetch weather. Is de device online?');
      }
    } else if(event is GetDetailedWeather) {
      try {
        final _weather = await weatherRepository.fetchDetailedWeather(event.cityName);
        yield WeatherLoaded(_weather);
      } on NetworkError {
        yield WeatherError('Couldn\'t fetch weather. Is de device online?');
      }

    }
  }
}