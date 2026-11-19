import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  late String time; // the time in that location
  String flag; // url to an assets flag icon
  String url; // location url for API endpoint
  late bool isDayTime; // true = day false = night

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // make request
      Response response = await get(
        Uri.parse("https://timeapi.io/api/Time/current/zone?timeZone=$url"),
      );

      // if (response.statusCode != 200) {
      //   print('Request failed: ${response.statusCode}');
      //   time = "No time data";
      //   return;
      // }

      Map<String, dynamic> data = jsonDecode(response.body);

      // timeapi.io's dateTime is already London local time, so no utc_offset math is needed
      String datetime = data['dateTime'];
      DateTime now = DateTime.parse(datetime);

      // set the time property
      // time = now.toString();

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = "No time data";
    }
  }
}
