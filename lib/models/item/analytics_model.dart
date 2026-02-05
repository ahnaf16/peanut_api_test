import 'package:post_wagens/models/item/item_model.dart';

class AnalyticsModel {
  final ItemModel item;
  final int totalViews;
  final int clicks;
  final List<EngagementDay> engagementLast7Days;
  final List<LocationShare> demographics;

  AnalyticsModel({
    required this.totalViews,
    required this.clicks,
    required this.engagementLast7Days,
    required this.demographics,
    required this.item,
  });
}

class EngagementDay {
  final String day;
  final int value;

  EngagementDay({required this.day, required this.value});
}

class LocationShare {
  final String location;
  final double percentage;

  LocationShare({required this.location, required this.percentage});
  double get normalizedValue => percentage / 100;
}
