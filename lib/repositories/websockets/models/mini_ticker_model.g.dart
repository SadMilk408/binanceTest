// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mini_ticker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MiniTickerModel _$MiniTickerModelFromJson(Map<String, dynamic> json) =>
    MiniTickerModel(
      tickerName: json['s'] as String? ?? '0',
      currentValue: json['c'] as String? ?? '0',
      openValue: json['o'] as String? ?? '0',
      quantity: json['q'] as String? ?? '0',
    );

Map<String, dynamic> _$MiniTickerModelToJson(MiniTickerModel instance) =>
    <String, dynamic>{
      's': instance.tickerName,
      'c': instance.currentValue,
      'o': instance.openValue,
      'q': instance.quantity,
    };
