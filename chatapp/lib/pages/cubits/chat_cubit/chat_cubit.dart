import 'package:chatapp/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  List<MessageModel> messageList = [];

  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        'messages': message,
        'createdAt': DateTime.now(),
        'id': email,
      });
    } catch (e) {
      // You could emit an error state here if needed
    }
  }

  void getMessage() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      List<MessageModel> messageList = [];

      for (var doc in event.docs) {
        messageList
            .add(MessageModel.fromjson(doc.data() as Map<String, dynamic>));
      }

      emit(ChatSuccess(messageList: messageList));
    });
  }
}
