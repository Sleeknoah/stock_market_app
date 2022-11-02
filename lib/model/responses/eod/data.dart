import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  double? open;
  double? high;
  double? low;
  double? close;
  int? volume;
  int? splitFactor;
  int? dividend;
  String? symbol;
  String? exchange;
  String? date;

  Data(
      {this.open,
      this.high,
      this.low,
      this.close,
      this.volume,
      this.splitFactor,
      this.dividend,
      this.symbol,
      this.exchange,
      this.date});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
