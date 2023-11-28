import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:calendar_app/screens/calendar/crud_event_screen.dart';
import 'package:calendar_app/widgets/calendar/event_list.dart';
import 'package:calendar_app/widgets/calendar/weather_info.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          title: const Text('Calendar'),
          backgroundColor: Theme.of(context).copyWith().primaryColor,
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
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.exit_to_app,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const WeatherInfo(), // Hiển thị thời tiết
          const Divider(color: Colors.grey),
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
          const Divider(color: Colors.grey),
          EventList(
            eventDay: DateFormat('dd/MM/yyyy').format(_selectedDay!),
          ), // Hiển thị event
        ],
      ),
    );
  }
}
