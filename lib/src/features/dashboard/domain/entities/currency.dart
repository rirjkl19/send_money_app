enum Currency {
  php(symbol: '₱'),
  usd(symbol: '\$');

  final String symbol;

  const Currency({required this.symbol});

  String get dtoName {
    switch (this) {
      case Currency.php:
        return 'PHP';
      case Currency.usd:
        return 'USD';
    }
  }

  static Currency fromDto(String currency) {
    switch (currency) {
      case 'PHP':
        return Currency.php;
      case 'USD':
        return Currency.usd;
      default:
        throw Exception('Invalid currency');
    }
  }
}
