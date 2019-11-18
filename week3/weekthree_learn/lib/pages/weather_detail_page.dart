import 'package:blocklearn/bloc/bloc.dart';
import 'package:blocklearn/data/model/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherDetailPage extends StatefulWidget {
  final Weather masterWeather;

  const WeatherDetailPage({Key key, @required this.masterWeather}) : super(key : key);

  @override
  _WeatherDetailPageState createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<WeatherBloc>(context)
    ..add(GetDetailedWeather(widget.masterWeather.cityName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherLoaded) {
              return buildResultData(context, state.weather);
            }
          },
        ),
      ),
    );
  }
  Column buildResultData(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        Column(
          children: <Widget>[
            Text(
              '${weather.temperatureCelcius.toStringAsFixed(1)} °C',
              style: TextStyle(fontSize: 80),
            ),
            Text(
              '${weather.temperatureFahrenheit.toStringAsFixed(1)} °F',
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ],
    );
  }
}