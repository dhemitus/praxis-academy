import 'dart:math';
import 'package:blocklearn/data/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
  Future<Weather> fetchDetailedWeather(String cityName);
}

class FetchWeatherRepository implements WeatherRepository {
  double _cachedTempCelcius;

  @override
  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final _random = Random();

        if(_random.nextBool()) {
          throw NetworkError();
        }

        _cachedTempCelcius = 20 + _random.nextInt(15) + _random.nextDouble();

        return Weather(
          cityName: cityName,
          temperatureCelcius: _cachedTempCelcius
        );
      }
    );
  }

  @override
  Future<Weather> fetchDetailedWeather(String cityName) {
    return Future.delayed(
      Duration(seconds: 1),
      () {

        return Weather(
          cityName: cityName,
          temperatureCelcius: _cachedTempCelcius,
          temperatureFahrenheit: _cachedTempCelcius * 1.8 + 32
        );
      }
    );
  }
}

class NetworkError extends Error {}