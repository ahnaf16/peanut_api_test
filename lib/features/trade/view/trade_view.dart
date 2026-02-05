import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peanut_api_test/features/trade/controller/trade_ctrl.dart';
import 'package:peanut_api_test/features/trade/view/trade_card.dart';

class TradeView extends HookConsumerWidget {
  const TradeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tradesAsync = ref.watch(tradeCtrlProvider);

    return tradesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Failed to load trades'),
            TextButton(onPressed: () => ref.invalidate(tradeCtrlProvider), child: const Text('Retry')),
          ],
        ),
      ),
      data: (trades) {
        if (trades.isEmpty) {
          return const Center(child: Text('No open trades'));
        }
        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(tradeCtrlProvider),
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: trades.length,
            separatorBuilder: (context, index) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              return TradeCard(trade: trades[index]);
            },
          ),
        );
      },
    );
  }
}
