import 'package:html/parser.dart';

abstract class StringHelpers {
  /// used to get the corrent Vidoe Link from the string
  static String getVideoID({required String url}) {
    url = url
        .replaceAll("https://www.youtube.com/watch?v=", "")
        .replaceAll(RegExp("&[a-zA-Z0-9-=_+&]*=[a-zA-Z0-9-=_+&]*"), '');
    url = url.replaceAll("https://m.youtube.com/watch?v=", "");
    url = url.replaceAll("https://youtu.be/", "");
    return url;
  }

  /// used to replace arabic numbers to english numbers in the String
  static String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }

  /// used tp Parse the [input] html5 document into a tree. The [input] can be a [String], [List] of bytes or an [HtmlTokenizer].
  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}
