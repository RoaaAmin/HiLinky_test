import 'package:cloud_firestore/cloud_firestore.dart';

class Reply {
  final String id;
  final String text;
  final DateTime date;

  Reply({
    required this.id,
    required this.text,
    required this.date,
  });

  factory Reply.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Reply(
      id: snapshot.id,
      text: data['text'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
    );
  }
}
