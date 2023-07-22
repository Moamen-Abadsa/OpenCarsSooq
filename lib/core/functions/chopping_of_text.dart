List<String> choppingOfText(String text) {
  String t = text.toLowerCase().replaceAll(' ', '').trim();
  return List<String>.generate(t.length, (index) => t[index]);
}