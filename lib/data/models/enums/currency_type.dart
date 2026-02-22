// ignore_for_file: constant_identifier_names

enum CurrencyType {
  TRY("TRY", "TL"),
  USD("USD", "\$"),
  EUR("EUR", "€");

  final String value;
  final String symbol;
  const CurrencyType(this.value, this.symbol);
}
