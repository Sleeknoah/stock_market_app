class RandomSymbols {
  static final symbols = [
    'APPL',
    'MSFT',
    'GOOG',
    'NFLX',
    'TWTR',
    'ABNB',
    'ADBE',
    'AMZN',
    'EBAY',
    'META',
    'UBER',
    'PYPL',
    'TSLA',
    'SPOT',
    'ZM',
  ];

  static String getRandomArray() {
    List<String> random = [];

    ///Randomise symbols array
    symbols.shuffle();
    for (int i = 0; i < 10; i++) {
      random.add(symbols[i]);
    }

    ///Join random and convert to string
    return random.join(",");
  }
}
