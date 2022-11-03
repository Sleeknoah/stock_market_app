import 'package:dio/dio.dart';
import 'package:stock_market_app/model/responses/intraday/intraday.dart';
import 'package:stock_market_app/model/service/market_services.dart';

class IntradayRepository {
  final MarketReportService service;

  IntradayRepository({required this.service});

  Future<Intraday> retrieveIntraday(
      String data, String start, String end) async {
    Response response = await service.retrieveEodIntraday(data, start, end);
    Intraday intraday = Intraday.fromJson(response.data);
    return intraday;
  }
}
