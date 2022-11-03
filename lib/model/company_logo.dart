class CompanyLogo {
  final String logo;
  final String symbol;

  CompanyLogo({
    required this.logo,
    required this.symbol,
  });

  @override
  String toString() {
    return logo;
  }

  static String search(List<CompanyLogo> object, String key) {
    late String result;
    for (int i = 0; i < object.length; i++) {
      if (object[i].symbol == key) {
        result = object[i].logo;
        break;
      }
    }
    return result;
  }
}

List<CompanyLogo> companyLogo = <CompanyLogo>[
  CompanyLogo(logo: 'apple', symbol: 'APPL'),
  CompanyLogo(logo: 'microsoft', symbol: 'MSFT'),
  CompanyLogo(logo: 'google', symbol: 'GOOG'),
  CompanyLogo(logo: 'netflix', symbol: 'NFLX'),
  CompanyLogo(logo: 'twitter', symbol: 'TWTR'),
  CompanyLogo(logo: 'airbnb', symbol: 'ABNB'),
  CompanyLogo(logo: 'adobe', symbol: 'ADBE'),
  CompanyLogo(logo: 'amazon', symbol: 'AMZN'),
  CompanyLogo(logo: 'ebay', symbol: 'EBAY'),
  CompanyLogo(logo: 'facebook', symbol: 'META'),
  CompanyLogo(logo: 'uber', symbol: 'UBER'),
  CompanyLogo(logo: 'paypal', symbol: 'PYPL'),
  CompanyLogo(logo: 'tesla', symbol: 'TSLA'),
  CompanyLogo(logo: 'spotify', symbol: 'SPOT'),
  CompanyLogo(logo: 'zoom', symbol: 'ZM'),
];
