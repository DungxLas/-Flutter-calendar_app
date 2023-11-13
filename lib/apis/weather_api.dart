import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherAPI {
  final String apiKey = '61f159a2aef034874f609c9b74be739f';

  Future getWeather(String city) async {
    http.Response response = await http.get(
      Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
