import 'package:flutter/material.dart';
import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/models/trade/trade_model.dart';

class TradeCard extends HookConsumerWidget {
  final TradeModel trade;

  const TradeCard({super.key, required this.trade});

  @override
  Widget build(BuildContext context, ref) {
    final isBuy = trade.type == 0;
    final tradeColor = isBuy ? Colors.blue : Colors.orange;

    final profitColor = trade.profit >= 0 ? Colors.green : Colors.red;

    final formatPrice = useCallback((num price) => price.toStringAsFixed(trade.digits), [trade.digits]);

    return DecoContainer(
      padding: Pads.all(16),
      color: context.colors.surfaceBright,
      borderRadius: 12,
      shadows: [BoxShadow(color: Colors.black.op(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(trade.symbol, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      spacing: 8,
                      children: [
                        Text(
                          isBuy ? 'BUY' : 'SELL',
                          style: TextStyle(color: tradeColor, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text('${trade.volume} Lots', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "${trade.profit >= 0 ? '+' : ''}${trade.profit.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: profitColor),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),

          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              _buildPriceInfo('Open', formatPrice(trade.openPrice)),
              const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
              _buildPriceInfo('Current', formatPrice(trade.currentPrice)),
              _buildPriceInfo('Ticket', trade.ticket.toString(), isEnd: true),
            ],
          ),
          const Gap(10),

          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                'SL: ${formatPrice(trade.sl)}  TP: ${formatPrice(trade.tp)}',
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Text(trade.openTime, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInfo(String label, String value, {bool isEnd = false}) {
    return Column(
      crossAxisAlignment: isEnd ? .end : .start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'monospace'),
        ),
      ],
    );
  }
}
