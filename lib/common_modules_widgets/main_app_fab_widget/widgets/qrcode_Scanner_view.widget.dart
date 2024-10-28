// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRScannerView extends StatefulWidget {
//   final GlobalKey qrKey;

//   const QRScannerView({super.key, required this.qrKey});

//   @override
//   QRScannerViewState createState() => QRScannerViewState();
// }

// class QRScannerViewState extends State<QRScannerView> {
//   QRViewController? controller;
//   String? scannedText;

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) async {
//       setState(() {
//         scannedText = scanData.code;
//       });

//       if (scannedText != null) {
//         // Return the scanned text and pop the view
//         Navigator.of(context).pop(scannedText);
//         controller.pauseCamera(); // Pause the camera after scanning
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Scan QR Code')),
//       body: QRView(
//         key: widget.qrKey,
//         onQRViewCreated: _onQRViewCreated,
//         overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: 300,
//         ),
//       ),
//     );
//   }
// }
