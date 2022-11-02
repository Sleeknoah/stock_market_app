// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      open: (json['open'] as num?)?.toDouble(),
      high: (json['high'] as num?)?.toDouble(),
      low: (json['low'] as num?)?.toDouble(),
      close: (json['close'] as num?)?.toDouble(),
      volume: (json['volume'] as num?)?.toDouble(),
      splitFactor: (json['splitFactor'] as num?)?.toDouble(),
      dividend: (json['dividend'] as num?)?.toDouble(),
      symbol: json['symbol'] as String?,
      exchange: json['exchange'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'close': instance.close,
      'volume': instance.volume,
      'splitFactor': instance.splitFactor,
      'dividend': instance.dividend,
      'symbol': instance.symbol,
      'exchange': instance.exchange,
      'date': instance.date,
    };
