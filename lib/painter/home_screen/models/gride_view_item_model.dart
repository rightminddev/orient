import 'package:flutter/material.dart';

class GrideViewItemModel {
  final String image;
  final String title;
  final onTap;
  final Color backgroundColor;

  GrideViewItemModel({required this.image, required this.title,required this.backgroundColor, required this.onTap});
}
