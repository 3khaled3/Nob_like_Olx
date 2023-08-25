class MessageDataModel {
  final String sender;
  final String receiver;
  final String content;
  var type;
  final DateTime timestamp;
  bool isRead;

  MessageDataModel({
    required this.sender,
    required this.receiver,
    required this.content,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });

  // Empty constructor
  MessageDataModel.empty()
      : sender = '',
        type = String,
        receiver = '',
        content = '',
        timestamp = DateTime.now(),
        isRead = false;
}
