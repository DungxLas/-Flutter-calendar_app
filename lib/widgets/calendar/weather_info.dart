import 'package:calendar_app/apis/weather_api.dart';
import 'package:flutter/material.dart';

class WeatherInfo extends StatefulWidget {
  const WeatherInfo({
    super.key,
  });

  @override
  State<WeatherInfo> createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  WeatherAPI weatherAPI = WeatherAPI();
  Map<String, dynamic>? _weatherData;
  var _city = '';
  var _temp = '';
  var _cond = '';
  var _condDetail = '';
  var _condIcon = '';

  void _fetchWeatherData(String city) async {
    try {
      var data = await weatherAPI.getWeather(city);
      if (data != null) {
        setState(() {
          _weatherData = data;
          _city = city;
          _temp = data['main']['temp'].toStringAsFixed(0);
          _cond = data['weather'][0]['main'];
          _condDetail = data['weather'][0]['description'];
          _condIcon = data['weather'][0]['icon'];
        });
      }
    } catch (e) {
      _weatherData = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeatherData('Hanoi');
  }

  void _showSearchDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter city name'),
            content: TextFormField(
              onChanged: (value) {
                _city = value;
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _fetchWeatherData(_city);
                  Navigator.of(context).pop();
                },
                child: const Text('Search'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    return _weatherData != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 80,
                child: ImageIcon(
                  NetworkImage(
                      'https://openweathermap.org/img/wn/$_condIcon@2x.png'),
                  size: 0.3 * width,
                ),
              ),
              Column(
                children: [
                  Text(
                    _city,
                  ),
                  Text(
                    '$_temp°K',
                  ),
                ],
              ),
              // const SizedBox(
              //   width: 40,
              // ),
              Column(
                children: [
                  Text(
                    _cond,
                  ),
                  Text(
                    _condDetail,
                  ),
                ],
              ),
              IconButton(
                onPressed: _showSearchDialog,
                icon: const Icon(
                  Icons.search,
                  size: 40,
                ),
              ),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }
}
