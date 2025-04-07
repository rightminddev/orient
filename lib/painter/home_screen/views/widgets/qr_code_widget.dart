import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/painter/home_screen/views/home_model.dart';

class QRScannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeModelProvider(),
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          return Consumer<HomeModelProvider>(
            builder: (context, provider, child) {
              if (provider.isSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    value.initializeHomeScreen(context);
                  }
                });
                provider.isSuccess = false;
              }
              return Scaffold(
                appBar: AppBar(title: Text(AppStrings.qrCodeScanner)),
                body: Stack(
                  alignment: Alignment.center,
                  children: [
                    MobileScanner(
                      onDetect: (BarcodeCapture barcode) {
                        if (barcode.barcodes.isNotEmpty) {
                          String? code = barcode.barcodes.first.rawValue;
                          if (code != null && !provider.isRequestSent) {
                            provider.isRequestSent = true; // Prevent multiple requests
                            provider.addRedeemGift(
                              context: context,
                              serial: code.toString(),
                            ).then((_) {
                              provider.isRequestSent = false; // Reset flag after completion
                            }).catchError((_) {
                              provider.isRequestSent = false; // Reset flag on error
                            });
                          }
                        }
                      },
                    ),
                    if (provider.isLoading)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
