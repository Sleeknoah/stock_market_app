import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market_app/model/repository/EodRepository.dart';
import 'package:stock_market_app/model/service/market_services.dart';

import '../../model/responses/eod/eod.dart';
import '../state_classes/eod_state_notifier.dart';
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
