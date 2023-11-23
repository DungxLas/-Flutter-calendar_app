import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key, required this.selectedDay});

  final DateTime selectedDay;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final _enventController = TextEditingController();

  TimeOfDay? _startTime;

  TimeOfDay? _endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('dd/MM').format(widget.selectedDay)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _enventController,
                decoration: const InputDecoration(
                  labelText: 'Please type new event',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          setState(() {
                            _startTime = selectedTime;
                          });
                        }
                      },
                      child: Text(
                        _startTime == null
                            ? 'Select start time'
                            : 'Start ${_startTime?.format(context)}',
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final buildContext = context;
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: buildContext,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          if (_startTime != null &&
                              (selectedTime.hour * 60 + selectedTime.minute) <
                                  (_startTime!.hour * 60 +
                                      _startTime!.minute)) {
                            ScaffoldMessenger.of(buildContext).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'The ending time cannot be earlier than the starting time!')),
                            );
                          } else {
                            setState(() {
                              _endTime = selectedTime;
                            });
                          }
                        }
                      },
                      child: Text(
                        _startTime == null
                            ? 'Select end time'
                            : 'End ${_endTime?.format(context)}',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
