class ChatList {
  final String id;
  final String name;
  final DateTime lastMessageTime;
  final String profilePicUrl;
  final String lastMessage;
  final int unreadCount;

  ChatList({
    required this.id,
    required this.name,
    required this.lastMessageTime,
    required this.profilePicUrl,
    required this.lastMessage,
    required this.unreadCount,
  });
}
