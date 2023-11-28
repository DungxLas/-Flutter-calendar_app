import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Create, Read, Update, Delete --> event
class EventScreen extends StatefulWidget {
  const EventScreen(
      {super.key,
      required this.selectedDay,
      this.start,
      this.end,
      this.event,
      this.eventId});

  final DateTime selectedDay;
  final String? event;
  final String? eventId;
  final String? start;
  final String? end;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  TextEditingController? _eventController;

  TimeOfDay? _startTime;

  TimeOfDay? _endTime;

  @override
  void initState() {
    super.initState();

    _eventController = TextEditingController(text: widget.event);
    _startTime = widget.start == null
        ? null
        : TimeOfDay.fromDateTime(DateFormat('HH:mm').parse(widget.start!));
    _endTime = widget.end == null
        ? null
        : TimeOfDay.fromDateTime(DateFormat('HH:mm').parse(widget.end!));
  }

  @override
  void dispose() {
    _eventController!.dispose();
    super.dispose();
  }

  void _submitEvent() async {
    final enteredEvent = _eventController!.text.trim();

    if (enteredEvent.isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    _eventController!.clear();

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    final eventDetails = {
      'text': enteredEvent,
      'start': '${_startTime!.hour}:${_startTime!.minute}',
      'end': '${_endTime!.hour}:${_endTime!.minute}',
      'createdFor': DateFormat('dd/MM/yyyy').format(widget.selectedDay),
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
    };

    if (widget.event != null &&
        widget.eventId != null &&
        widget.start != null &&
        widget.end != null) {
      await FirebaseFirestore.instance
          .collection('event')
          .doc(widget.eventId)
          .update(eventDetails);
    } else {
      await FirebaseFirestore.instance.collection('event').add(eventDetails);
    }
  }

  void _deleteEvent() async {
    FirebaseFirestore.instance.collection('event').doc(widget.eventId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('dd/MM/yyyy').format(widget.selectedDay)),
        actions: [
          if (widget.event != null &&
              widget.eventId != null &&
              widget.start != null &&
              widget.end != null)
            IconButton(
                onPressed: () {
                  _deleteEvent();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete)),
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
                  controller: _eventController,
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
