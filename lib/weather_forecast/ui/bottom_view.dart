import 'package:flutter/material.dart';
import 'package:weather/weather_forecast/model/weather_forecast_model.dart';

import 'forecast_card.dart';

class BottomView extends StatelessWidget {

  final AsyncSnapshot<WeatherForecastModel> snapshot;

  const BottomView({Key key, this.snapshot}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container (
      child:
      Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text("7-day weather forecast".toUpperCase(),
          style: TextStyle(
            fontSize: 17,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          )
          ),
        ),
        Container(
          height: 170,
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 10.0), 
            itemCount: snapshot.data.daily.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: forecastCard(snapshot, index),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.blueAccent[100], Colors.grey[100]],
                    begin: Alignment.topLeft, end: Alignment.bottomRight
                    )
                  ) 
                ),
                );
            }, 

            )
        )

      ],
  )
    );
  }
}
