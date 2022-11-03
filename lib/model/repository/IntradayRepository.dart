import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market_app/model/responses/intraday/intraday.dart';
import 'package:stock_market_app/model/service/market_services.dart';

class IntradayRepository {
  final MarketReportService service;

  IntradayRepository({required this.service});

  Future<Intraday> retrieveIntraday(String data, WidgetRef ref) async {
    Response response = await service.retrieveEodIntraday(data, ref);
    Intraday intraday = Intraday.fromJson(response.data);
    return intraday;
  }
}
