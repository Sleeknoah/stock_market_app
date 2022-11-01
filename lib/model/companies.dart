class Companies {
  final String name;
  final String symbol;

  Companies({
    required this.name,
    required this.symbol,
  });

  @override
  String toString() {
    return '$name $symbol';
  }
}

List<Companies> companies = <Companies>[
  Companies(name: 'Apple Inc', symbol: 'APPL'),
  Companies(name: 'Microsoft Corp', symbol: 'MSFT'),
  Companies(name: 'Alphabet Inc', symbol: 'GOOG'),
  Companies(name: 'Netflix Inc', symbol: 'NFLX'),
  Companies(name: 'Twitter Inc', symbol: 'TWTR'),
  Companies(name: 'Airbnb Inc', symbol: 'ABNB'),
  Companies(name: 'Adobe Inc', symbol: 'ADBE'),
  Companies(name: 'Amazon.com Inc', symbol: 'AMZN'),
  Companies(name: 'Ebay Inc', symbol: 'EBAY'),
  Companies(name: 'Meta Platforms Inc', symbol: 'META'),
  Companies(name: 'Uber Technologies Inc', symbol: 'UBER'),
  Companies(name: 'PayPal Holdings Inc', symbol: 'PYPL'),
  Companies(name: 'Tesla Inc', symbol: 'TSLA'),
  Companies(name: 'Spotify Technology SA', symbol: 'SPOT'),
  Companies(name: 'Zoom Video Communications Inc', symbol: 'ZM'),
];
