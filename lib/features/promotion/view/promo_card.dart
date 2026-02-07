import 'package:flutter/material.dart';
import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/models/promo/promo_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoCard extends StatelessWidget {
  final PromoModel promo;

  const PromoCard({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UImage(
            promo.imageUrl ?? LIcon.image,
            height: 150,
            width: double.infinity,
            backgroundColor: context.colors.surfaceContainerHighest,
          ),
          Padding(
            padding: Pads.med(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: Insets.xs,
                  children: [
                    Expanded(child: Text(promo.title, style: context.text.bodyLarge?.semiBold)),

                    GestureDetector(
                      onTap: () {
                        try {
                          launchUrl(Uri.parse(promo.link));
                        } catch (_) {}
                      },
                      child: DecoContainer(
                        padding: Pads.sym(12, 3),
                        color: context.colors.primaryContainer,
                        borderRadius: 99,
                        child: Icon(Icons.arrow_forward_rounded, color: context.colors.primary, size: 18),
                      ),
                    ),
                  ],
                ),

                if (promo.description.isNotEmpty)
                  Text(
                    promo.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.labelLarge?.outline,
                  ),
                const Gap(Insets.xs),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
