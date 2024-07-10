class LanguageModel {
  final String languageCountryCode;
  final String language;
  final String englishLanguageName;

  LanguageModel(
    this.languageCountryCode,
    this.englishLanguageName,
    this.language,
  );
}

List<LanguageModel> languages = [
  LanguageModel("en", "English", "English"),
  LanguageModel("es", "Spanish", "Español"),
];
