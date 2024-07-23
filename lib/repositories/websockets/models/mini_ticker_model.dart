// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//  "s": "ETHUSDT",			// ticker name
//  "c": "1779.15000000",		// “close” - use as a current value
//  "o": "1778.21000000",		// “open” - to know 24H difference
//  "q": "1384265939.01393710"	// “quantity” - use as a volume
// }

import 'package:json_annotation/json_annotation.dart';

part 'mini_ticker_model.g.dart';

@JsonSerializable()
class MiniTickerModel {
  @JsonKey(name: 's', defaultValue: '0')
  final String? tickerName;
  @JsonKey(name: 'c', defaultValue: '0')
  final String? currentValue;
  @JsonKey(name: 'o', defaultValue: '0')
  final String? openValue;
  @JsonKey(name: 'q', defaultValue: '0')
  final String? quantity;
  final String? percentDiff;

  MiniTickerModel({
    this.tickerName,
    this.currentValue,
    this.openValue,
    this.quantity,
    this.percentDiff,
  });

  String roundMillions() {
    try {
      return (double.parse(quantity ?? '0.0') / 1000000).toStringAsFixed(2);
    } catch (e) {
      return '';
    }
  }

  String percentDifference(String? tempOpenValue) {
    if (tempOpenValue == null || openValue == null) {
      return '0.0';
    }
    final tempValue = double.tryParse(tempOpenValue) ?? 0.0;
    final newValue = double.tryParse(openValue ?? '0.0') ?? 0.0;

    return ((tempValue - newValue) * 100 / tempValue).toStringAsFixed(2);
  }

  bool? get greenDiff => (double.tryParse(percentDiff ?? '0.0') ?? 0) * -1 < 0;

  factory MiniTickerModel.fromJson(Map<String, dynamic> json) =>
      _$MiniTickerModelFromJson(json);

  Map<String, dynamic> toJson() => _$MiniTickerModelToJson(this);

  MiniTickerModel copyWith({
    String? tickerName,
    String? currentValue,
    String? openValue,
    String? quantity,
    String? percentDiff,
  }) {
    return MiniTickerModel(
      tickerName: tickerName ?? this.tickerName,
      currentValue: currentValue ?? this.currentValue,
      openValue: openValue ?? this.openValue,
      quantity: quantity ?? this.quantity,
      percentDiff: percentDiff ?? this.percentDiff,
    );
  }
}
