class SearchValidator {
  static String? validateCityName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a city name';
    }

    final RegExp specialChars = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (specialChars.hasMatch(value)) {
      return 'City name cannot contain special characters';
    }

    final RegExp numbers = RegExp(r'[0-9]');
    if (numbers.hasMatch(value)) {
      return 'City name cannot contain numbers';
    }

    return null;
  }
}
