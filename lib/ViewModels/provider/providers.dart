import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market_app/model/repository/EodRepository.dart';
import 'package:stock_market_app/model/responses/intraday/intraday.dart';
import 'package:stock_market_app/model/service/market_services.dart';
import 'package:stock_market_app/utils/connectivity.dart';

import '../../model/repository/IntradayRepository.dart';
import '../../model/responses/eod/data.dart';
import '../../model/responses/eod/eod.dart';
import '../state_classes/eod_state_notifier.dart';
import '../state_classes/intraday_state_notifier.dart';
import '../states/network.dart';

///Set loading to true initially
final loadingProvider = StateProvider.autoDispose<bool>((ref) => true);

///Set retrieval state_classes to initial
///states are initial, loading, loaded, error
final retrieveStateProvider =
    StateProvider.autoDispose<NetworkState>((ref) => NetworkState.loading);

///Dependency injection of eod repository done here with riverpod
final eodRepositoryProvider = Provider<EodRepository>((ref) {
  return EodRepository(service: MarketReportService());
});

///Eod state notifier provider
final eodDataProvider = StateNotifierProvider<EodStateNotifier, Eod?>(
  (ref) {
    final repository = ref.watch(eodRepositoryProvider);
    return EodStateNotifier(null, repository);
  },
);

final filterProvider = StateProvider<String>((ref) => '');

///Get list of data
final dataProvider = StateProvider<List<Data>?>((ref) {
  final eod = ref.watch(eodDataProvider);
  final filterString = ref.watch(filterProvider);
  if (filterString.isEmpty) {
    eod?.data;
  }
  return eod?.data
      ?.where(
          (x) => x.symbol!.toLowerCase().contains(filterString.toLowerCase()))
      .toList();
});

///Dependency injection of intraday repository done here with riverpod
final intradayRepositoryProvider = Provider<IntradayRepository>((ref) {
  return IntradayRepository(service: MarketReportService());
});

///Intraday state notifier provider
final intradayDataProvider =
    StateNotifierProvider<IntradayStateNotifier, Intraday?>(
  (ref) {
    final repository = ref.watch(intradayRepositoryProvider);
    return IntradayStateNotifier(null, repository);
  },
);

///Start date provider with initial value 7 days from current date
final dateTimeStart = StateProvider.autoDispose<DateTime>((ref) {
  final dateTime = DateTime.now().subtract(
    const Duration(
      days: 7,
    ),
  );
  return dateTime;
});

///End date provider with initial value as current date
final endTimeStart = StateProvider.autoDispose<DateTime>((ref) {
  return DateTime.now();
});

///Set loading to true initially
final loadingDetailsProvider = StateProvider.autoDispose<bool>((ref) => true);

///Set Error to empty initially
final errorDetailsProvider = StateProvider.autoDispose<String>((ref) => '');

///Set Error to empty initially
final errorProvider = StateProvider.autoDispose<String>((ref) => '');

///Set up Connectivity provider
final connectivity = Provider<ConnectivityService>((ref) {
  return ConnectivityService(StreamController<ConnectivityResult>());
});

///Set up internet checker stream
final internetProvider = StreamProvider<ConnectivityResult>((ref) {
  final connection = ref.watch(connectivity);
  connection.checkNetwork();
  return connection.networkStatusController.stream;
});
