import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Create, Read, Update, Delete --> event
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
  void dispose() {
    _enventController.dispose();
    super.dispose();
  }

  void _submitEvent() async {
    final enteredEvent = _enventController.text;

    if (enteredEvent.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    _enventController.clear();

    // send to Firebase
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    FirebaseFirestore.instance.collection('event').add({
      'text': enteredEvent,
      'start': '${_startTime!.hour}:${_startTime!.minute}',
      'end': '${_endTime!.hour}:${_endTime!.minute}',
      'createdFor': DateFormat('dd/MM/yyyy').format(widget.selectedDay),
      'createedAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('dd/MM/yyyy').format(widget.selectedDay)),
        actions: [
          IconButton(
            onPressed: () {
              _submitEvent();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          shadowColor: Colors.black,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _enventController,
                  decoration: const InputDecoration(
                    labelText: 'Please type new event',
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                              // ignore: use_build_context_synchronously
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
      ),
    );
  }
}
