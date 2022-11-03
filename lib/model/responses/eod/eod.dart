import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'eod.g.dart';

@JsonSerializable()
class Eod {
  List<Data>? data;

  Eod({this.data});

  factory Eod.fromJson(Map<String, dynamic> json) => _$EodFromJson(json);

  Map<String, dynamic> toJson() => _$EodToJson(this);
}
