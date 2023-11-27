import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  const EventList({super.key, required this.eventDay});

  final String eventDay;

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('event')
          .where('userId', isEqualTo: authenticatedUser.uid)
          .where('createdFor', isEqualTo: eventDay)
          .snapshots(),
      builder: (ctx, eventSnapshots) {
        if (eventSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
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

        return Expanded(
          child: ListView.builder(
            //shrinkWrap: true,
            itemCount: loadedEvent.length,
            itemBuilder: (ctx, index) {
              final event = loadedEvent[index].data();
              final eventText = event['text'];
              final eventStart = event['start'];
              final eventEnd = event['end'];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Card(
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(eventStart),
                            Text(eventEnd),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(eventText),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
