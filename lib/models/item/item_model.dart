import 'package:post_wagens/models/user/user_model.dart';

class ItemModel {
  final String id;
  final List<String> imageUrls;
  final List<String> videoUrls;
  final String title;
  final num price;
  final String location;
  final bool isSaved;
  final UserModel seller;
  final VehicleDetails vehicleDetails;
  final String description;
  final DateTime createdAt;
  final DateTime? boastEndsAt;
  final bool isBoasted;

  ItemModel({
    required this.id,
    required this.imageUrls,
    required this.videoUrls,
    required this.title,
    required this.price,
    required this.location,
    required this.seller,
    required this.vehicleDetails,
    required this.description,
    this.isSaved = false,
    required this.createdAt,
    this.boastEndsAt,
    required this.isBoasted,
  });
}

class VehicleDetails {
  final int year;
  final String mileage;
  final String transmission;
  final String fuel;
  final String color;
  final String condition;

  VehicleDetails({
    required this.year,
    required this.mileage,
    required this.transmission,
    required this.fuel,
    required this.color,
    required this.condition,
  });
}
