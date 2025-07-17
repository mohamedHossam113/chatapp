class MessageModel {
  final String messages;
  final String id;
  MessageModel(this.messages, this.id);
  factory MessageModel.fromjson(jsonData) {
    return MessageModel(jsonData["messages"], jsonData['id']);
  }
}
