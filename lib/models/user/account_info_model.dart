import 'package:peanut_api_test/_core/extensions/map_extension.dart';

class AccountInfoModel {
  final String name;
  final num balance;
  final String address;
  final String city;
  final String country;
  final int currency;
  final int currentTradesCount;
  final num currentTradesVolume;
  final num equity;
  final num freeMargin;
  final bool isAnyOpenTrades;
  final bool isSwapFree;
  final int leverage;
  final String phone;
  final num totalTradesCount;
  final num totalTradesVolume;
  final int type;
  final int verificationLevel;
  final String zipCode;

  AccountInfoModel({
    required this.name,
    required this.balance,
    required this.address,
    required this.city,
    required this.country,
    required this.currency,
    required this.currentTradesCount,
    required this.currentTradesVolume,
    required this.equity,
    required this.freeMargin,
    required this.isAnyOpenTrades,
    required this.isSwapFree,
    required this.leverage,
    required this.phone,
    required this.totalTradesCount,
    required this.totalTradesVolume,
    required this.type,
    required this.verificationLevel,
    required this.zipCode,
  });

  factory AccountInfoModel.fromMap(Map<String, dynamic> map) {
    return AccountInfoModel(
      name: map['name'],
      balance: map.parseNum('balance'),
      address: map['address'],
      city: map['city'],
      country: map['country'],
      currency: map.parseInt('currency'),
      currentTradesCount: map.parseInt('currentTradesCount'),
      currentTradesVolume: map.parseNum('currentTradesVolume'),
      equity: map.parseNum('equity'),
      freeMargin: map.parseNum('freeMargin'),
      isAnyOpenTrades: map.parseBool('isAnyOpenTrades'),
      isSwapFree: map.parseBool('isSwapFree'),
      leverage: map.parseInt('leverage'),
      phone: map['phone'],
      totalTradesCount: map.parseInt('totalTradesCount'),
      totalTradesVolume: map.parseNum('totalTradesVolume'),
      type: map.parseInt('type'),
      verificationLevel: map.parseInt('verificationLevel'),
      zipCode: map['zipCode'],
    );
  }
}
