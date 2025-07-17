part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
  List<MessageModel> messageList = [];
  ChatSuccess({required this.messageList});
}
