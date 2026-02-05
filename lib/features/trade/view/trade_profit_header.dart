import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peanut_api_test/features/profile/controller/profile_ctrl.dart';
import 'package:peanut_api_test/main.export.dart';

class TotalTradesProfitHeader extends ConsumerWidget {
  const TotalTradesProfitHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalProfit = ref.watch(totalTradesProfitProvider);

    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final bool isPositive = totalProfit >= 0;

    return DecoContainer(
      width: double.infinity,
      padding: Pads.lg(),
      color: isPositive ? Colors.green.shade50 : Colors.red.shade50,
      borderRadius: 15,
      borderWidth: 1,
      borderColor: isPositive ? Colors.green.shade200 : Colors.red.shade200,

      child: Column(
        children: [
          Text(
            'TOTAL OPEN TRADES PROFIT',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isPositive ? Colors.green.shade800 : Colors.red.shade800,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${isPositive ? '+' : ''}${formatter.format(totalProfit)}",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isPositive ? Colors.green.shade700 : Colors.red.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
