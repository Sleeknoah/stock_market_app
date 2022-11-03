import 'package:stock_market_app/model/responses/intraday/data.dart';

class ListHelper {
  static List<double> dataset(List<Data> data) {
    List<double> dataset = [];
    for (int i = 0; i < data.length; i++) {
      dataset.add(data[i].close!);
    }
    return dataset;
  }
}
