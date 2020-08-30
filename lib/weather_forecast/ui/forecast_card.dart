
import 'package:flutter/material.dart';
import 'package:weather/weather_forecast/model/weather_forecast_model.dart';
import 'package:weather/weather_forecast/util/forecast_util.dart';

Widget forecastCard(AsyncSnapshot<WeatherForecastModel> snapshot, int index) {
    final daily = snapshot.data.daily;
    var dayOfWeek = "";
    final fullDate = Util.getFormattedDate(new DateTime.fromMillisecondsSinceEpoch(daily[index].dt * 1000));
    dayOfWeek = fullDate.split(",")[0];
    var icon = daily[index].weather[0].icon;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
          Center( 
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(dayOfWeek, style: TextStyle(fontSize: 19.0, color: Colors.black87),) ),),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10.0,),
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.blue[100],
                child:
                 Image.network("http://openweathermap.org/img/wn/$icon@2x.png")
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text("${daily[index].temp.max.toStringAsFixed(0)}°", style: TextStyle(fontSize: 17.0)),
                      ),
                      Text("${daily[index].temp.min.toStringAsFixed(0)}°", style: TextStyle(fontSize: 17.0)),
                    ],
                ),)

            ],),
      ],);
}