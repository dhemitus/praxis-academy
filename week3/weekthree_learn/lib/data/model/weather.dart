import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperatureCelcius;
  final double temperatureFahrenheit;

  Weather({
    @required this.cityName, 
    @required this.temperatureCelcius, 
    this.temperatureFahrenheit
  });

  @override
  List<Object> get props => [
    cityName,
    temperatureCelcius,
    temperatureFahrenheit
  ];
}