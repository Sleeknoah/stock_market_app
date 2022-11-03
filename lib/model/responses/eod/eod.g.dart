// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Eod _$EodFromJson(Map<String, dynamic> json) => Eod(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EodToJson(Eod instance) => <String, dynamic>{
      'data': instance.data,
    };
