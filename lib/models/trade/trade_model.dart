import 'package:peanut_api_test/_core/extensions/map_extension.dart';

class TradeModel {
  const TradeModel({
    required this.currentPrice,
    required this.comment,
    required this.digits,
    required this.login,
    required this.openPrice,
    required this.openTime,
    required this.profit,
    required this.sl,
    required this.swaps,
    required this.symbol,
    required this.tp,
    required this.ticket,
    required this.type,
    required this.volume,
  });

  final num currentPrice;
  final String? comment;
  final int digits;
  final int login;
  final num openPrice;
  final String openTime;
  final num profit;
  final num sl;
  final num swaps;
  final String symbol;
  final num tp;
  final int ticket;
  final int type;
  final num volume;

  factory TradeModel.fromMap(Map<String, dynamic> map) {
    return TradeModel(
      currentPrice: map.parseNum('currentPrice'),
      comment: map['comment'],
      digits: map.parseInt('digits'),
      login: map.parseInt('login'),
      openPrice: map.parseNum('openPrice'),
      openTime: map['openTime'],
      profit: map.parseNum('profit'),
      sl: map.parseNum('sl'),
      swaps: map.parseNum('swaps'),
      symbol: map['symbol'],
      tp: map.parseNum('tp'),
      ticket: map.parseInt('ticket'),
      type: map.parseInt('type'),
      volume: map.parseNum('volume'),
    );
  }

  static TradeModel? tryParse(dynamic value) {
    try {
      if (value case final TradeModel model) return model;
      if (value case final Map m) return TradeModel.fromMap(m.toStringKey());
    } catch (e) {
      return null;
    }
    return null;
  }
}
