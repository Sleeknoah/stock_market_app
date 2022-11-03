// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intraday.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Intraday _$IntradayFromJson(Map<String, dynamic> json) => Intraday(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IntradayToJson(Intraday instance) => <String, dynamic>{
      'data': instance.data,
    };
