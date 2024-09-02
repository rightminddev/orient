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
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    // Example: Password should be at least 8 characters with one uppercase letter, one lowercase letter, one number, and one special character
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Password must be at least 8 characters with at least one uppercase letter, one lowercase letter, one number, and one special character';
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
