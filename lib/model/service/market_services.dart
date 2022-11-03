import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ViewModels/provider/providers.dart';
import '../../utils/format_date.dart';
import '../network/dio_client.dart';
import '../network/network_constants.dart';

class MarketReportService {
  var options = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    receiveDataWhenStatusError: true,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );

  Future<dynamic> retrieveEod(String data, WidgetRef ref) async {
    var dio = DioClient(option: options).client();
    try {
      Response response = await dio.get(
        '${ApiConstants.eodUrl}?access_key=${ApiConstants.API_KEY}&symbols=$data',
      );
      return response;
    } on DioError catch (e) {
      switch (e.response?.statusCode) {
        case 429:
          ref.read(errorProvider.notifier).state =
              'Oops your free plan is used up';
          break;
        case null:
          ref.read(errorProvider.notifier).state =
              'Please check your internet connection';
          break;

        default:
          ref.read(errorProvider.notifier).state =
              'Oops. Something went wrong. Please try again';
          break;
      }
    }
  }

  Future<dynamic> retrieveEodIntraday(String data, WidgetRef ref) async {
    var dio = DioClient(option: options).client();
    final startDate = ref.read(dateTimeStart);
    final endDate = ref.read(endTimeStart);
    try {
      Response response = await dio.get(
        '${ApiConstants.intradayUrl}?access_key=${ApiConstants.API_KEY}'
        '&symbols=$data&date_from=${DateTimeFormat.format(startDate)}'
        '&date_to=${DateTimeFormat.format(endDate)}',
      );
      return response;
    } on DioError catch (e) {
      switch (e.response?.statusCode) {
        case 429:
          ref.read(errorDetailsProvider.notifier).state =
              'Oops your free plan is used up.';
          break;
        case null:
          ref.read(errorDetailsProvider.notifier).state =
              'Please check your internet connection';
          break;

        default:
          ref.read(errorDetailsProvider.notifier).state =
              'Oops. Something went wrong. Please try again';
          break;
      }
    }
  }
}
