import 'package:flutter/material.dart';

abstract class PrintLargeDataService {
  static void printLargeData(String data, {int chunkSize = 800}) {
    int len = data.length;
    for (int i = 0; i < len; i += chunkSize) {
      debugPrint(data.substring(i, i + chunkSize > len ? len : i + chunkSize));
    }
  }
}
