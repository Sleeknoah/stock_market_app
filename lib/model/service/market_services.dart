import 'package:dio/dio.dart';

import '../network/api_constants.dart';
import '../network/dio_client.dart';

class MarketReportService {
  var options = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    receiveDataWhenStatusError: true,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );

  Future<dynamic> retrieveEod(String apiKey, String data) async {
    var dio = DioClient(option: options).client();
    Map<String, dynamic> query = {};
    query['access_token'] = apiKey;
    query['symbols'] = data;
    try {
      Response response = await dio.get(
        ApiConstants.eodUrl,
        queryParameters: query,
      );
      return response;
    } on DioError catch (e) {
      throw 'error';
    }
  }
}
