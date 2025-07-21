import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messages;
  final String id;

  MessageModel({required this.messages, required this.id});

  factory MessageModel.fromjson(DocumentSnapshot doc) {
    // ignore: unused_local_variable
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel(messages: doc['message'], id: doc['id']);
  }
}
