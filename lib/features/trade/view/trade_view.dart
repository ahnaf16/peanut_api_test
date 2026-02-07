import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
          data: (trades) {
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: Pads.lg('lr'),
                  sliver: SliverList.list(
                    children: [
                      const TotalTradesProfitHeader(),
                      const Gap(Insets.sm),
                      Text(
                        '${trades.length} Active Positions',
                        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                      const Gap(Insets.sm),
                    ],
                  ),
                ),

                if (context.isLandscape)
                  SliverPadding(
                    padding: Pads.lg('lr'),
                    sliver: SliverMasonryGrid(
                      crossAxisSpacing: Insets.med,
                      mainAxisSpacing: Insets.med,
                      delegate: SliverChildBuilderDelegate(childCount: trades.length, (context, index) {
                        final trade = trades[index];
                        return TradeCard(trade: trade);
                      }),
                      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    ),
                  )
                else
                  SliverPadding(
                    padding: Pads.lg('lr'),
                    sliver: SliverList.builder(
                      itemCount: trades.length,
                      itemBuilder: (context, index) {
                        final trade = trades[index];
                        return TradeCard(trade: trade);
                      },
                    ),
                  ),

                const SliverGap(Insets.lg),
              ],
            );
          },
        ),
      ),
    );
  }
}
