import 'package:chatapp/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('message');

  List<MessageModel> messageList = [];

  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        'message': message,
        'createdAt': DateTime.now(),
        'id': email,
      });
    } catch (e) {
      // You can log or handle errors here
      print("Send message error: $e");
    }
  }

  void getmessages() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      // ✅ Correct list generation using .map()
      // messageList =
      //     event.docs.map((doc) => MessageModel.fromjson(doc)).toList();
      messageList.clear();
      for (var doc in event.docs) {
        messageList.add(MessageModel.fromjson(doc));
      }
      print('Fetched ${messageList.length} messages');
      emit(ChatSuccess(messages: List.from(messageList)));
    });
  }
}
