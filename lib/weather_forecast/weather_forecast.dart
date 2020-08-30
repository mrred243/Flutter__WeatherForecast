

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather/weather_forecast/model/weather_forecast_model.dart';
import 'package:weather/weather_forecast/network/network.dart';
import 'package:weather/weather_forecast/ui/bottom_view.dart';
import 'package:weather/weather_forecast/ui/mid_view.dart';


class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {

  Future<WeatherForecastModel> forecastObject;
  String _location = "Helsinki";
  dynamic  locationDetails;

  
  //Function get location details
  dynamic getLocationDetail ({ String cityName}) async {
  var locationUrl = "http://www.mapquestapi.com/geocoding/v1/address?key=PYgVpcqfrzY0sjRhOwzMBRzCOAPANQ1c&location=" + cityName;

  final response = await get(Uri.encodeFull(locationUrl));

  if ( response.statusCode == 200 ) {
    final locationResult = jsonDecode(response.body);
    final location = locationResult["results"][0]["locations"][0];
    if (location["adminArea5"] != "") {
    setState(() {
      locationDetails = location;
      print("locationDetails : $locationDetails");
    });
    }


  } else {
    throw Exception("Error getting location.");
  }
}

  @override
    void initState()  {
      super.initState();
      getLocationDetail(cityName: _location);
      forecastObject = getWeather(lat: 60.166628, lon: 24.943508);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget> [
          textViewField(),
          Container(
            child: FutureBuilder(
              future: forecastObject,
              builder: (BuildContext context, AsyncSnapshot<WeatherForecastModel> snapshot ){
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text("${locationDetails["adminArea5"]}, ${locationDetails["adminArea1"]} ",
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                                color: Colors.black87
                              ),
                      ),
                          ),
                        MidView(snapshot: snapshot),
                        BottomView(snapshot: snapshot)
                      ]
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: Center(
                        child: SizedBox(
                          width: 150.0,
                          height: 150.0,
                          child: CircularProgressIndicator() ,),
                      )
                    );
                  }
              }),
            )
        ],
      ),
    );
            }
          
  Widget textViewField() {
    return Container(
      padding: EdgeInsets.all(15.0) ,
      child: TextField(
        decoration: InputDecoration(hintText: "Enter a city and country",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(8)
        ),
        onSubmitted: (value) {
          setState(() {
            _location = value;
            getLocationDetail(cityName: _location);
            forecastObject = getWeather(lat: locationDetails["latLng"]["lat"], lon: locationDetails["latLng"]["lng"]);
          });
        },
        )
    );
  }

  Future<WeatherForecastModel> getWeather({double lat, double lon}) => new Network().getWeatherForecast(lat: lat, lon: lon );
}