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
  const CurrencyModel("CNY", "¥"),
  const CurrencyModel("INR", "₹"),
];
