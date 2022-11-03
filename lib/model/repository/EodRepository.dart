import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market_app/model/responses/eod/eod.dart';
import 'package:stock_market_app/model/service/market_services.dart';

class EodRepository {
  final MarketReportService service;

  EodRepository({required this.service});

  Future<Eod> retrieveEod(String data, WidgetRef ref) async {
    Response response = await service.retrieveEod(data, ref);
    Eod eod = Eod.fromJson(response.data);
    return eod;
  }
}
