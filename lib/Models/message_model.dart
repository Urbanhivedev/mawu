class Message {
  final String message;
  final DateTime time;
  final String sendBy;

  Message({
    required this.message,
    required this.sendBy,
    required this.time,
  });

  static Message fromJson(json) => Message(
        message: json['message'],
        time: json['time'],
        sendBy: json['sendBy'],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "time": time,
        "sendBy": sendBy,
      };
}
