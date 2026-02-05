import '../user/user_model.dart';

class CommentModel {
  final String id;
  final UserModel user;
  final String message;
  final DateTime createdAt;
  final List<CommentModel> replies;
  final bool isLiked;
  final int likesCount;

  CommentModel({
    required this.id,
    required this.user,
    required this.message,
    required this.createdAt,
    this.replies = const [],
    this.isLiked = false,
    this.likesCount = 0,
  });
}
