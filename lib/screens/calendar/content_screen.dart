import 'package:calendar_app/screens/calendar/crud_event_screen.dart';
import 'package:calendar_app/widgets/calendar/event_list.dart';
import 'package:calendar_app/widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../apis/weather_api.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  WeatherAPI weatherAPI = WeatherAPI();
  var _city;
  var _weatherData;
  var _temp;
  var _cond;
  var _condDetail;
  var _condIcon;

  void fetchWeatherData(String city) async {
    var data = await weatherAPI.getWeather(city);
    setState(() {
      _weatherData = data;
      _city = city;
      _temp = data['main']['temp'].toStringAsFixed(0);
      _cond = data['weather'][0]['main'];
      _condDetail = data['weather'][0]['description'];
      _condIcon = data['weather'][0]['icon'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData('Hanoi');
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EventScreen(
                    selectedDay: _selectedDay!,
                  ),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: _weatherData != null
                ? WeatherInfo(
                    city: _city,
                    temp: _temp,
                    cond: _cond,
                    condDetail: _condDetail,
                    condIcon: _condIcon,
                  )
                : const Center(child: CircularProgressIndicator()),
          ), // Hiển thị thời tiết
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const EventList(), // Hiển thị event
        ],
      ),
    );
  }
}
