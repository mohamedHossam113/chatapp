class MessageModel {
  final String messages;
  MessageModel(this.messages);
  factory MessageModel.Fromjson(jsonData) {
    return MessageModel(jsonData["messages"]);
  }
}
