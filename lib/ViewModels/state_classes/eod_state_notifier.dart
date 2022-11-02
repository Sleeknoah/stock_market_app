import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market_app/model/network/network_constants.dart';
import 'package:stock_market_app/model/repository/EodRepository.dart';
import 'package:stock_market_app/model/responses/eod/eod.dart';

class EodStateNotifier extends StateNotifier<Eod?> {
  final EodRepository repository;
  EodStateNotifier(super.state, this.repository);

  void retrieveStatus(WidgetRef ref, String data) async {
    // var loadingState = ref.watch(loadingProvider.notifier);
    // loadingState.state = true;
    try {
      final response = await repository.retrieveEod(ApiConstants.API_KEY, data);
      if (response.data != null) {
        state = response;
        print(response.data);
        // loadingState.state = false;
      }
    } catch (e) {
      state = null;
    }
  }
}
