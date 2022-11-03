import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'intraday.g.dart';

@JsonSerializable()
class Intraday {
  List<Data>? data;

  Intraday({this.data});

  factory Intraday.fromJson(Map<String, dynamic> json) =>
      _$IntradayFromJson(json);

  Map<String, dynamic> toJson() => _$IntradayToJson(this);
}
