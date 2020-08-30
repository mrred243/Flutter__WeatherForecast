import 'package:flutter/material.dart';
import 'package:weather/weather_forecast/model/weather_forecast_model.dart';
import 'package:weather/weather_forecast/util/forecast_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MidView extends StatelessWidget {

  final AsyncSnapshot<WeatherForecastModel> snapshot;

  const MidView ({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = new DateTime.fromMillisecondsSinceEpoch(snapshot.data.daily[0].dt * 1000);

    return 
        Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
          child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [

            Text("${Util.getFormattedDate(formattedDate)}", 
            style: TextStyle( fontSize: 17)),
            
            SizedBox(height: 30.0,),
           
            Container(
            

            width: 300, 
            height: 200,
            decoration: BoxDecoration(
                color: Colors.blue[100],
                image: DecorationImage(image: NetworkImage("http://openweathermap.org/img/wn/${snapshot.data.current.weather[0].icon}@2x.png"),
                        fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(10)
                )
            ),

            SizedBox(height: 15.0,),


            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${snapshot.data.daily[0].temp.day.toStringAsFixed(0)}°C",
                    style: TextStyle(fontSize: 45),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: 
                      Text("${snapshot.data.daily[0].weather[0].description.toUpperCase()}",
                      style: TextStyle(fontSize: 22),
                       ) 
                    )
   
            ],),
            ),
                  Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${snapshot.data.daily[0].windSpeed} m/s"),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child:
                              Icon(FontAwesomeIcons.wind, size: 30, color: Colors.lightBlue[300],)
                            ),                          
                        ],),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${snapshot.data.daily[0].humidity.toString()} %"),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Icon(FontAwesomeIcons.water, size: 30, color: Colors.lightBlue[300],)
                            ),                        ],),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${snapshot.data.daily[0].temp.max.toStringAsFixed(0)} °C"),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Icon(FontAwesomeIcons.temperatureHigh, size: 30, color: Colors.lightBlue[300],)
                            ),

                        ],),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${snapshot.data.daily[0].temp.min.toStringAsFixed(0)} °C"),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Icon(FontAwesomeIcons.temperatureLow, size: 30, color: Colors.lightBlue[300],)
                            ),
                        ],),
                    ]
                  )
                  )
          ]
        ),
        )

    );
  } }