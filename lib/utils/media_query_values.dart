import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  static const Size designSize = Size(390, 844);
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get toPadding => MediaQuery.of(this).viewPadding.top;
  double get bottom => MediaQuery.of(this).viewInsets.bottom;
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;
  // double get authScreenPadding => MediaQuery.of(this).size.width*.04;
  // double get screenPadding => MediaQuery.of(this).size.width*.02;

  // double pixelTodb(double pixel)=> pixel/devicePixelRatio;
  // double h(double height)=> height*this.height/designSize.height;
  // double w(double width)=>  width*this.width/designSize.width;
}
