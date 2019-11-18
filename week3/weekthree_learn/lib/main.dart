import 'package:blocklearn/bloc/bloc.dart';
import 'package:blocklearn/data/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:blocklearn/pages/weather_search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        builder: (context) =>WeatherBloc(FetchWeatherRepository()),
        child: WeatherSearchPage(),
      ),
    );
  }
}