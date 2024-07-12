class CurrencyModel {
  final String currency;
  final String currencySymbol;

  const CurrencyModel(this.currency, this.currencySymbol);
}

List<CurrencyModel> currencies = [
  const CurrencyModel("USD", "\$"),
  const CurrencyModel("EUR", "€"),
  const CurrencyModel("GBP", "£"),
  const CurrencyModel("JPY", "¥"),
  const CurrencyModel("CNY", "¥"), // Renminbi (Yuan)
  const CurrencyModel("INR", "₹"),
  const CurrencyModel("HKD", "HK\$"), // Hong Kong Dollar
  const CurrencyModel("SGD", "S\$"), // Singapore Dollar
  const CurrencyModel("AUD", "A\$"), // Australian Dollar
  const CurrencyModel("CAD", "C\$"), // Canadian Dollar
  const CurrencyModel("CHF", "CHF"), // Swiss Franc
  const CurrencyModel("KRW", "₩"), // South Korean Won
  const CurrencyModel("MYR", "RM"), // Malaysian Ringgit
  const CurrencyModel("THB", "฿"), // Thai Baht
];
