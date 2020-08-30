
import 'dart:convert';

import 'package:weather/weather_forecast/model/weather_forecast_model.dart';
import 'package:weather/weather_forecast/util/forecast_util.dart';
import 'package:http/http.dart';

class Network {

  Future <WeatherForecastModel> getWeatherForecast ({ double lat, double lon }) async{


    var finalUrl = "http://api.openweathermap.org/data/2.5/onecall?lat=" + lat.toString() + "&lon=" + lon.toString() + "&units=metric&appId=" + Util.appId;
    print("$finalUrl");


    final response = await get(Uri.encodeFull(finalUrl));

    if (response.statusCode == 200){
      return WeatherForecastModel.fromJson(json.decode(response.body));
    }else {
      throw Exception("Error getting weather forecast.");
    }
  }
}