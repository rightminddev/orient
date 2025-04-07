import 'package:flutter/material.dart';

class GrideViewItemModel {
  final String image;
  final String title;
  String? description;
  final onTap;
  final Color backgroundColor;

  GrideViewItemModel({required this.image,this.description, required this.title,required this.backgroundColor, required this.onTap});
}
