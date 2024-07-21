bool isEnglishText(String text) {
  final pattern = RegExp(r'[a-zA-Z]');
  return pattern.hasMatch(text);
}
