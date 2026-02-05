import 'package:post_wagens/models/chat/message_model.dart';
import 'package:post_wagens/models/user/user_model.dart';

class InboxThreadModel {
  const InboxThreadModel({required this.id, required this.sender, this.lastMessage, required this.allRead});

  final String id;
  final UserModel sender;
  final MessageModel? lastMessage;
  final bool allRead;
}
