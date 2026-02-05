import 'package:peanut_api_test/models/chat/message_model.dart';
import 'package:peanut_api_test/models/user/user_model.dart';

class InboxThreadModel {
  const InboxThreadModel({required this.id, required this.sender, this.lastMessage, required this.allRead});

  final String id;
  final UserModel sender;
  final MessageModel? lastMessage;
  final bool allRead;
}
