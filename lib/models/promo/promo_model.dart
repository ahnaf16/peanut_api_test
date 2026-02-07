import 'package:peanut_api_test/main.export.dart';

class PromoModel {
  final String title;
  final String description;
  final String? imageUrl;
  final String link;

  PromoModel({required this.title, required this.description, required this.imageUrl, required this.link});

  static PromoModel? fromXml(dynamic element) {
    try {
      final String rawImage = element.findElements('Image').first.innerText;

      final String formattedImage = rawImage.replaceAll('forex-images.instaforex.com', 'forex-images.ifxdb.com');

      return PromoModel(
        title: element.findElements('Title').first.innerText,
        description: element.findElements('Description').first.innerText,
        imageUrl: formattedImage,
        link: element.findElements('Link').first.innerText,
      );
    } catch (e, s) {
      catErr('XML Fail', e, s);
      return null;
    }
  }
}
