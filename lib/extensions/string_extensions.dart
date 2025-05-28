extension StringExtensions on String {
  /// Capitalizes the first letter of the string.
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  /// Converts the string to camelCase.
  String toCamelCase() {
    return split(' ').map((String word) {
      return word.capitalize();
    }).join();
  }

  /// Converts the string to snake_case.
  String toSnakeCase() {
    return split(' ').join('_').toLowerCase();
  }

  /// Converts the string to kebab-case.
  String toKebabCase() {
    return split(' ').join('-').toLowerCase();
  }

  /// Converts the string to PascalCase.
  String toPascalCase() {
    return split(' ').map((String word) {
      return word.capitalize();
    }).join();
  }
}
