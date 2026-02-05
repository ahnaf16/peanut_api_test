import 'package:flutter/material.dart';
import 'package:peanut_api_test/features/trade/controller/trade_ctrl.dart';
import 'package:peanut_api_test/features/trade/view/trade_card.dart';
import 'package:peanut_api_test/features/trade/view/trade_profit_header.dart';
import 'package:peanut_api_test/main.export.dart';

class TradeView extends HookConsumerWidget {
  const TradeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tradesAsync = ref.watch(tradeCtrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Open Trades')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(tradeCtrlProvider.future),
        child: tradesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => Center(child: Text('Error: $e')),
          data: (trades) => ListView(
            padding: Pads.lg(),
            children: [
              const TotalTradesProfitHeader(),
              const Gap(Insets.sm),
              Text(
                '${trades.length} Active Positions',
                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              const Gap(Insets.sm),

              ...trades.map((trade) => TradeCard(trade: trade)).gapBy(Insets.med),

              const Gap(Insets.lg),
            ],
          ),
        ),
      ),
    );
  }
}
