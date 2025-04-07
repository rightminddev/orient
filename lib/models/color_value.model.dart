import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ColorValue {
  late Color light;
  late Color dark;
  Color get color =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark
          ? dark
          : light;

  Color get(bool isDark) => isDark ? dark : light;
  ColorValue({Color? light, Color? dark}) {
    this.light = light ?? Colors.white;
    this.dark = dark ?? Colors.black;
  }
}
