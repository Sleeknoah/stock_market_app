import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/repository/IntradayRepository.dart';
import '../../model/responses/intraday/intraday.dart';

class IntradayStateNotifier extends StateNotifier<Intraday?> {
  final IntradayRepository repository;
  IntradayStateNotifier(super.state, this.repository);

  void retrieveIntraday(String data, WidgetRef ref) async {
    try {
      final response = await repository.retrieveIntraday(data, ref);
      if (response.data != null) {
        state = response;
      }
    } catch (e) {
      state = null;
    }
  }
}
