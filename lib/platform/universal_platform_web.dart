// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

// NOTE:
// Never import this library directly in the application. The PlatformIs
// class and library uses conditional imports to only import this file on
// Web platform builds.

final html.Navigator _nav = html.window.navigator;

abstract class UniversalPlatform {
  static bool get web => true;
  static bool get macOS => _nav.appVersion.contains('Mac OS') && !iOS;
  static bool get windows => _nav.appVersion.contains('Win');
  static bool get linux =>
      (_nav.appVersion.contains('Linux') || _nav.appVersion.contains('x11')) &&
      !android;
  static bool get android => _nav.appVersion.contains('Android ');
  static bool get iOS {
    return _hasMatch(_nav.platform, '/iPad|iPhone|iPod/') ||
        (_nav.platform == 'MacIntel' && _nav.maxTouchPoints! > 1);
  }

  static bool get fuchsia => false;
}

bool _hasMatch(String? value, String pattern) {
  return (value == null) ? false : RegExp(pattern).hasMatch(value);
}
