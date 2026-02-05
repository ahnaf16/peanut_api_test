import 'package:peanut_api_test/models/user/user_model.dart';

class PostModel {
  final String id;
  final UserModel user;
  final String caption;
  final List<String> imageUrls;
  final List<String> videoUrls;
  final DateTime postTime;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final bool isSaved;
  final bool isLiked;
  final bool isActive;

  PostModel({
    required this.id,
    required this.caption,
    required this.imageUrls,
    required this.videoUrls,
    required this.postTime,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    required this.isSaved,
    required this.isLiked,
    required this.isActive,
    required this.user,
  });
}
