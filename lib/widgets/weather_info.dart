import 'package:flutter/material.dart';

class WeatherInfo extends StatefulWidget {
  const WeatherInfo({
    super.key,
    required this.city,
    required this.temp,
    required this.cond,
    required this.condDetail,
    required this.condIcon,
  });
  final String city, temp, cond, condDetail, condIcon;

  @override
  State<WeatherInfo> createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    return Row(
      children: [
        ImageIcon(
          NetworkImage(
              'https://openweathermap.org/img/wn/${widget.condIcon}@2x.png'),
          size: 0.3 * width,
        ),
        Column(
          children: [
            Text(
              widget.city,
              // style: const TextStyle(
              //   fontSize: 30,
              // ),
            ),
            Text(
              '${widget.temp}°K',
              // style: const TextStyle(
              //   fontSize: 48,
              // ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              widget.cond,
              // style: const TextStyle(
              //   fontSize: 30,
              // ),
            ),
            Text(
              widget.condDetail,
              // style: const TextStyle(
              //   fontSize: 30,
              // ),
            ),
          ],
        ),
      ],
    );
  }
}
