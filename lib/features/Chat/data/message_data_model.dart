class MessageDataModel {
  final String id;
  final String sender;
  final String receiver;
  final String content;
  final DateTime timestamp;
  bool isRead;

  MessageDataModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.timestamp,
    this.isRead = false,
  });

  // Empty constructor
  MessageDataModel.empty()
      : id = '',
        sender = '',
        receiver = '',
        content = '',
        timestamp = DateTime.now(),
        isRead = false;
}
