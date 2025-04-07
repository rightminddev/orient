import 'package:easy_localization/easy_localization.dart';
import 'package:orient/constants/app_strings.dart';

abstract class ValidationService {
  // Validate email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    // Regex pattern for email validation
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Validate phone number format
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    // Regex pattern for phone number validation
    String pattern = r'^[0-9]{10}$'; // Change pattern as per your requirement
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Validate password format
  static String? validatePassword(String? value, {bool login = false}) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterAPassword.tr();
    }

    if (!login) {
      String upperCasePattern = r'(?=.*?[A-Z])'; // At least one uppercase letter
      String lowerCasePattern = r'(?=.*?[a-z])'; // At least one lowercase letter
      String numberPattern = r'(?=.*?[0-9])';    // At least one number
      String specialCharPattern = r'(?=.*?[!@#\$&*~])'; // At least one special character
      String minLengthPattern = r'.{8,}';        // At least 8 characters

      List<String> missingCriteria = [];

      // Check each requirement
      if (!RegExp(upperCasePattern).hasMatch(value)) {
        missingCriteria.add(AppStrings.atLeastOneUppercaseLetter.tr());
      }
      if (!RegExp(lowerCasePattern).hasMatch(value)) {
        missingCriteria.add(AppStrings.atLeastOneLowercaseLetter.tr());
      }
      if (!RegExp(numberPattern).hasMatch(value)) {
        missingCriteria.add(AppStrings.atLeastOneNumber.tr());
      }
      if (!RegExp(specialCharPattern).hasMatch(value)) {
        missingCriteria.add(AppStrings.atLeastOneSpecialCharacter.tr());
      }
      if (!RegExp(minLengthPattern).hasMatch(value)) {
        missingCriteria.add(AppStrings.aMinimumOfEightCharacters.tr());
      }

      if (missingCriteria.isNotEmpty) {
        return "${AppStrings.mustInclude.tr()}: ${missingCriteria.join(', ')}.";
      }
    }

    return null;
  }

  // Validate required field
  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // Validate numeric input
  static String? validateNumeric(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional validation if empty value is allowed
    }
    String pattern = r'^[0-9]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter only numeric characters';
    }
    return null;
  }

  // Validate URL format
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional validation if empty value is allowed
    }
    String pattern =
        r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$';
    RegExp regex = RegExp(pattern, caseSensitive: false);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  // Validate date format
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional validation if empty value is allowed
    }
    // Customize date format pattern as per your requirement
    String pattern = r'^\d{4}-\d{2}-\d{2}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid date (YYYY-MM-DD)';
    }
    // Additional validation logic can be added to check if the date is valid
    return null;
  }
}
