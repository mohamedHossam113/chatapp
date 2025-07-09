class MessageModel {
  final String messages;
  final String id;
  MessageModel(this.messages, this.id);
  factory MessageModel.Fromjson(jsonData) {
    return MessageModel(jsonData["messages"], jsonData['id']);
  }
}
