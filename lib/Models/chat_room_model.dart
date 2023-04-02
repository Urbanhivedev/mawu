class ChatRoom {
  final String chatRoomId;
  final List<dynamic> users;
  // final String sendBy;

  ChatRoom({
    required this.users,
    required this.chatRoomId,
    //required this.time,
  });

  static ChatRoom fromJson(json) => ChatRoom(
        users: json['users'],
        chatRoomId: json['chatRoomId'],
        //sendBy: json['sendBy'],
      );

  Map<String, dynamic> toJson() => {
        "users": users,
        "chatRoomId": chatRoomId,
        //"sendBy": sendBy,
      };
}
