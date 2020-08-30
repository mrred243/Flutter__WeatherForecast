import 'package:intl/intl.dart';

class Util {
  //Add openweather appId
  static String appId = "9dc04ed28efffe2f5c57c64b15bc1c50";

  static String getFormattedDate(DateTime datetime){
    return new DateFormat("EEEE, MMM d, y").format(datetime);
  }
}