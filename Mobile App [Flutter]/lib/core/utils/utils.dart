
String removeNumbersSuffix(String input) {
  // Use a regular expression to remove "-1", "-2", etc. at the end of the string
  return input.replaceAll(RegExp(r'-\d+$'), '');
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String fixWhiteSpaceInUrl() {
    // Replace white spaces with '%20'
    return Uri.encodeFull(this);
  }

  String removeWwwFromUrl() {
    if (startsWith('https://www.')) {
      return 'https://${substring(12)}';
    } else if (startsWith('http://www.')) {
      return 'http://${substring(11)}';
    }
    return this;
  }
}

String convertToJsonStringQuotes({required String raw}) {
  String jsonString = raw;

  /// add quotes to json string
  jsonString = jsonString.replaceAll('{', '{"');
  jsonString = jsonString.replaceAll(': ', '": "');
  jsonString = jsonString.replaceAll(', ', '", "');
  jsonString = jsonString.replaceAll('}', '"}');

  /// remove quotes on object json string
  jsonString = jsonString.replaceAll('"{"', '{"');
  jsonString = jsonString.replaceAll('"}"', '"}');

  /// remove quotes on array json string
  jsonString = jsonString.replaceAll('"[{', '[{');
  jsonString = jsonString.replaceAll('}]"', '}]');

  return jsonString;
}