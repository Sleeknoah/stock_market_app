import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market_app/utils/format_date.dart';

import '../../model/repository/IntradayRepository.dart';
import '../../model/responses/intraday/intraday.dart';
import '../provider/providers.dart';

class IntradayStateNotifier extends StateNotifier<Intraday?> {
  final IntradayRepository repository;
  IntradayStateNotifier(super.state, this.repository);

  void retrieveIntraday(String data, WidgetRef ref) async {
    try {
      final startDate = ref.read(dateTimeStart);
      final endDate = ref.read(endTimeStart);
      final response = await repository.retrieveIntraday(data,
          DateTimeFormat.format(startDate), DateTimeFormat.format(endDate));
      if (response.data != null) {
        state = response;
      }
    } catch (e) {
      state = null;
    }
  }
}
