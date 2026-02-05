import 'package:flutter/material.dart';
import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/models/item/item_model.dart';
import 'package:peanut_api_test/models/user/user_model.dart';

enum NotificationType {
  social,
  marketplace;

  IconData get icon => switch (this) {
    social => LIcon.users,
    marketplace => LIcon.shoppingBag,
  };
}

class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    this.sender,
    this.item,
  });

  final String id;
  final String title;
  final String body;
  final DateTime date;
  final UserModel? sender;
  final ItemModel? item;
}
