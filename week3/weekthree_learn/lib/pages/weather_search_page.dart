import 'package:blocklearn/main.dart';
import 'package:blocklearn/pages/weather_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocklearn/bloc/bloc.dart';
import 'package:blocklearn/data/model/weather.dart';

class WeatherSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if(state is WeatherError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                )
              );
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if(state is WeatherInitial) {
                return Center(
                  child: CityInputField(),
                );
              } else if(state is WeatherLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WeatherLoaded) {
                return Center(
                  child: buildResultData(context, state.weather),
                );
              } else if (state is WeatherError) {
                return Center(
                  child: CityInputField(),
                );
              }
            },
          ),
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
        Text(
          '${weather.temperatureCelcius.toStringAsFixed(1)} °C',
          style: TextStyle(fontSize: 80),
        ),
        RaisedButton(
          child: Text(
            'See Details'
          ),
          color: Colors.lightBlue[100],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<WeatherBloc>(context),
                  child: WeatherDetailPage(masterWeather: weather,),
                )
              )
            );
          },
        ),
        CityInputField()
      ],
    );
  }

}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (val) => _submitCityName(context, val),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Enter a city',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          suffixIcon: Icon(Icons.search)
        ),
      ),
    );
  }

  void _submitCityName(BuildContext context, String cityName) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    _weatherBloc.add(GetWeather(cityName));
  }
}