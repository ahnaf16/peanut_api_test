import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peanut_api_test/main.export.dart';

class ProfitSummaryCard extends StatelessWidget {
  const ProfitSummaryCard({
    super.key,
    required this.balance,
    required this.equity,
    required this.freeMargin,
    required this.leverage,
  });

  final num balance;
  final num equity;
  final num freeMargin;
  final int leverage;

  @override
  Widget build(BuildContext context) {
    final floatingProfit = equity.toDouble() - balance.toDouble();
    final isProfit = floatingProfit >= 0;

    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return DecoContainer(
      padding: const EdgeInsets.all(20),
      gradient: LinearGradient(
        colors: isProfit ? [Colors.blue.shade800, Colors.blue.shade600] : [Colors.red.shade800, Colors.red.shade600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: 20,
      shadows: [
        BoxShadow(color: (isProfit ? Colors.blue : Colors.red).op3, blurRadius: 12, offset: const Offset(0, 6)),
      ],

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Floating Profit',
                style: TextStyle(color: Colors.white.op(0.8), fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.op(0.2), borderRadius: BorderRadius.circular(8)),
                child: Text('1:$leverage', style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          const Gap(8),

          Text(
            "${isProfit ? '+' : ''}${formatter.format(floatingProfit)}",
            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -1),
          ),
          const Gap(20),
          Divider(color: Colors.white.op2),
          const Gap(15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetric('Balance', formatter.format(balance)),
              _buildMetric('Equity', formatter.format(equity)),
              _buildMetric('Free Margin', formatter.format(freeMargin)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white.op7, fontSize: 12)),
        const Gap(4),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
