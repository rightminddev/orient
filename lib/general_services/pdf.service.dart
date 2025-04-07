import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

abstract class PDFCreation {
  /// Method to create a PDF document with given filename and data
  static Future<File> createMethod(
      {required String fileName, required Map<String, String> data}) async {
    // Create a new PDF document
    final PdfDocument document = PdfDocument();

    // Add a page to the document
    final PdfPage page = document.pages.add();

    // Variable to keep track of the current height for text placement
    double height = 0.0;

    // Iterate over the data map and draw each key-value pair in the PDF
    data.forEach((key, value) {
      _drawItem(
        page: page,
        title: key,
        value: value,
        titleDimensions: Rect.fromLTWH(0, height, 150, 20),
        valueDimensions: Rect.fromLTWH(250, height, 150, 20),
      );
      height += 20.0; // Increment height for the next item
    });

    // Save the document as a list of bytes
    List<int> bytes = document.saveSync();
    // Dispose the document to release resources
    document.dispose();

    // Save the bytes to a file and return the file
    return await _saveFile(fileName: fileName, bytes: bytes);
  }

  /// Method to save a list of bytes as a file with the given filename
  static Future<File> _saveFile(
      {required String fileName, required List<int> bytes}) async {
    // Get the directory to save the file
    final Directory? directory =
        (await getExternalStorageDirectories(type: StorageDirectory.documents))
            ?.first;
    // Create a file in the directory with the given filename
    File file = File("${directory?.path}/$fileName.pdf");

    // Write the bytes to the file
    var savedFile = await file.writeAsBytes(bytes);
    return savedFile;
  }

  /// Method to draw a key-value pair on the PDF page
  static void _drawItem({
    required PdfPage page,
    required String title,
    required String value,
    required Rect titleDimensions,
    required Rect valueDimensions,
  }) {
    // Draw the title (key) on the page
    page.graphics.drawString(
      title,
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: titleDimensions,
    );
    // Draw the value on the page
    page.graphics.drawString(
      value,
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: valueDimensions,
    );
  }
}
