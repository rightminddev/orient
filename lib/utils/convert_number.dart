class ConvertNumber{
  static String convertToArabicDigits(int number) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    String numberString = number.toString();
    String arabicNumber = '';

    for (int i = 0; i < numberString.length; i++) {
      int digit = int.parse(numberString[i]);
      arabicNumber += arabicDigits[digit];
    }

    return arabicNumber;
  }
}