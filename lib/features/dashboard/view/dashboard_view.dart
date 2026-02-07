import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:peanut_api_test/features/dashboard/view/profit_summary_card.dart';
import 'package:peanut_api_test/features/profile/controller/profile_ctrl.dart';
import 'package:peanut_api_test/features/trade/controller/trade_ctrl.dart';
import 'package:peanut_api_test/features/trade/view/trade_card.dart';
import 'package:peanut_api_test/main.export.dart';

class DashboardView extends HookConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountData = ref.watch(accountInfoCtrlProvider);
    final phoneData = ref.watch(phoneDigitCtrlProvider);
    final tradesData = ref.watch(tradeCtrlProvider);
    return accountData.when(
      loading: () => const Center(child: CircularProgressIndicator()).withSF('Profile'),
      error: (e, s) => Center(
        child: ErrorView(e, s, prov: [accountInfoCtrlProvider, tradeCtrlProvider, phoneDigitCtrlProvider]),
      ).withSF('Profile'),
      data: (account) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: kToolbarHeight + 15,
            title: Column(
              crossAxisAlignment: .start,
              spacing: 2,
              children: [
                Text('Welcome, ${account.name}'),
                phoneData.when(
                  loading: () => const LoaderBox(height: 40, width: 110),
                  error: (e, s) => const SizedBox.shrink(),
                  data: (digits) {
                    if (digits == null) return const SizedBox.shrink();
                    return Row(
                      spacing: 4,
                      children: [
                        Text(
                          digits,
                          style: context.text.labelMedium?.op(.5).textHeight(1).copyWith(fontFamily: 'monospace'),
                        ),
                      ],
                    );
                  },
                ),
                const Gap(0),
                Row(
                  spacing: 4,
                  children: [
                    const Icon(LIcon.mapPin, size: 12, color: Colors.grey),
                    Text(account.address, style: context.text.labelSmall?.regular.op(.5).textHeight(1)),
                  ],
                ),
              ],
            ),
          ),
          body: Padding(
            padding: Pads.lg(),
            child: Refresher(
              onRefresh: () async {
                ref.invalidate(phoneDigitCtrlProvider);
                ref.invalidate(tradeCtrlProvider);
                return ref.invalidate(accountInfoCtrlProvider);
              },
              child: CustomScrollView(
                clipBehavior: .none,
                slivers: [
                  SliverToBoxAdapter(
                    child: ProfitSummaryCard(
                      balance: account.balance,
                      equity: account.equity,
                      freeMargin: account.freeMargin,
                      leverage: account.leverage,
                    ),
                  ),
                  const SliverGap(Insets.sm),
                  Row(
                    spacing: Insets.sm,
                    children: [
                      Expanded(child: Text('Open Trades', style: context.text.titleMedium)),
                      TextButton(onPressed: () => RPaths.trades.push(context), child: const Text('View')),
                    ],
                  ).toSliver(),

                  tradesData.when(
                    loading: () => const Center(child: CircularProgressIndicator()).toSliver(),
                    error: (e, stack) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Failed to load trades'),
                          TextButton(onPressed: () => ref.invalidate(tradeCtrlProvider), child: const Text('Retry')),
                        ],
                      ).toSliver(),
                    ),
                    data: (trades) {
                      if (context.isLandscape) {
                        return SliverMasonryGrid(
                          crossAxisSpacing: Insets.med,
                          mainAxisSpacing: Insets.med,
                          delegate: SliverChildBuilderDelegate(childCount: trades.length, (context, index) {
                            final trade = trades[index];
                            return TradeCard(trade: trade);
                          }),
                          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        );
                      } else {
                        return SliverList.separated(
                          itemCount: trades.length,
                          separatorBuilder: (_, _) => const Gap(Insets.lg),
                          itemBuilder: (context, index) => TradeCard(trade: trades[index]),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
