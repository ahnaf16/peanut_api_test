import 'package:post_wagens/models/item/item_model.dart';
import 'package:post_wagens/models/user/user_model.dart';

enum FileType { image, video, document }

class MessageModel {
  const MessageModel({
    required this.id,
    required this.text,
    required this.sender,
    required this.files,
    required this.time,
    this.item,
    this.isRead = true,
    this.isSend = true,
  });

  final String id;
  final String text;
  final UserModel sender;
  final List<MessageFile> files;
  final DateTime time;
  final ItemModel? item;
  final bool isRead;
  final bool isSend;
}

class MessageFile {
  const MessageFile({required this.url, required this.type});

  final String url;
  final FileType type;
}
