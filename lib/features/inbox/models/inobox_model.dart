// USER CHAT CARD MODEL

class UserChatCardModel {
  final String uid;
  final String username;
  final String chatReply;

  UserChatCardModel({
    required this.uid,
    required this.username,
    required this.chatReply,
  });

  factory UserChatCardModel.fromMap(Map<String, dynamic> map) {
    return UserChatCardModel(
      uid: map['uid'],
      username: map['username'],
      chatReply: map['chatReply'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'chatReply': chatReply,
    };
  }
}

//USER CHAT MODEL

class UserChatModel {
  final String uid;
  final String username;
  final List<String> messages;

  UserChatModel({
    required this.uid,
    required this.username,
    required this.messages,
  });

  factory UserChatModel.fromMap(Map<String, dynamic> map) {
    return UserChatModel(
      uid: map['uid'],
      username: map['username'],
      messages: List<String>.from(map['messages'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'messages': messages,
    };
  }
}

//NOTIFICATION MODEL

class NotificationModel {
  final String uid;
  final String username;
  final String notificationMessage;

  NotificationModel({
    required this.uid,
    required this.username,
    required this.notificationMessage,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      uid: map['uid'],
      username: map['username'],
      notificationMessage: map['notificationMessage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'notificationMessage': notificationMessage,
    };
  }
}
