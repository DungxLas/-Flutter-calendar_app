import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('event').snapshots(),
      builder: (ctx, eventSnapshots) {
        if (eventSnapshots.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!eventSnapshots.hasData || eventSnapshots.data!.docs.isEmpty) {
          return const Center(
            child: Text('No event found.'),
          );
        }

        if (eventSnapshots.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }

        final loadedEvent = eventSnapshots.data!.docs;

        return ListView.builder(
          itemCount: loadedEvent.length,
          itemBuilder: (ctx, index) {
            final event = loadedEvent[index].data();
            final eventText = event['text'];
            final eventStart = event['start'];
            final eventEnd = event['end'];

            return Card(
              child: Row(
                children: [
                  CircleAvatar(
                    child: Column(
                      children: [
                        Text(eventStart),
                        Text(eventEnd),
                      ],
                    ),
                  ),
                  Text(eventText),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
