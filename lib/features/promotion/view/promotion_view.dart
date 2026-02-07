import 'package:flutter/material.dart';
import 'package:peanut_api_test/features/promotion/controller/promotion_ctrl.dart';
import 'package:peanut_api_test/features/promotion/view/promo_card.dart';
import 'package:peanut_api_test/main.export.dart';

class PromotionView extends HookConsumerWidget {
  const PromotionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promoData = ref.watch(promotionCtrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Promotions')),
      body: promoData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) {
          return Center(child: ErrorView(e, s, reload: () => ref.read(promotionCtrlProvider.notifier).refresh()));
        },

        data: (promos) {
          return Refresher(
            onRefresh: () async => ref.invalidate(promotionCtrlProvider),
            child: promos.isEmpty
                ? NoDataFound(
                    icon: const Icon(LIcon.listFilterPlus),
                    text: 'No promotions found',
                    subtext: 'Check back later',
                    isScrollable: true,
                    prov: [promotionCtrlProvider],
                  )
                : ListView.separated(
                    padding: Pads.lg(),
                    itemCount: promos.length,
                    separatorBuilder: (_, _) => const Gap(Insets.med),
                    itemBuilder: (BuildContext context, int index) {
                      final promo = promos[index];
                      return PromoCard(promo: promo);
                    },
                  ),
          );
        },
      ),
    );
  }
}
