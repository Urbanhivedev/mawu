import 'app_user_model.dart';

class ChatMap {
  final String chatRoomId;
  final AppUser users;
  // final String sendBy;

  ChatMap({
    required this.users,
    required this.chatRoomId,
    //required this.time,
  });
}

class UnreadModel {
  final String unreadBy;

  final int unreadCount;

  UnreadModel({
    required this.unreadBy,
    required this.unreadCount,
  });

  static UnreadModel fromJson(json) => UnreadModel(
        unreadBy: json['unreadBy'],
        unreadCount: json['unreadCount'],
      );

  Map<String, dynamic> toJson() => {
        "unread": unreadBy,
        "unreadCount": unreadCount,
      };
}
