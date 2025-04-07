import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../general_services/layout.service.dart';
import '../../../../models/fingerprint.model.dart';

class FingerprintDetailsModalSheet extends StatelessWidget {
  final FingerPrintModel fingerprint;
  const FingerprintDetailsModalSheet({super.key, required this.fingerprint});

  @override
  Widget build(BuildContext context) {
    String? formatDateString(String? dateString) {
      if (dateString == null) return null;
      // Parse the string into a DateTime object
      DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateString);

      // Format the DateTime object into the desired format
      String formattedDate = DateFormat('EEEE, dd MMM yyyy').format(dateTime);

      return formattedDate;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        gapH20,
        if (formatDateString(fingerprint.fingerDay) != null) ...[
          gapH12,
          Container(
            padding: const EdgeInsets.all(AppSizes.s12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.s10),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Center(
              child: Text(
                formatDateString(fingerprint.fingerDay) ?? '',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: AppSizes.s14),
              ),
            ),
          ),
        ],
        gapH12,
        if (fingerprint.fingerDateTime != null &&
            fingerprint.fingerDateTime?.isNotEmpty == true)
          ...fingerprint.fingerDateTime!
              .map((fingerprintDatetime) => FingerprintDatetimeCardWidget(
                    fingerprintDatetime: fingerprintDatetime,
                    isIn: (fingerprint.fingerDateTime
                                    ?.indexOf(fingerprintDatetime) ??
                                0) %
                            2 ==
                        0,
                  ))
      ],
    );
  }
}

class FingerprintDatetimeCardWidget extends StatelessWidget {
  final FingerDateTime fingerprintDatetime;
  final bool? isIn;
  const FingerprintDatetimeCardWidget(
      {super.key, required this.fingerprintDatetime, this.isIn = true});

  @override
  Widget build(BuildContext context) {
    String getFingerprintImageDependsOnType({required String fingerprintType}) {
      switch (fingerprintType.trim().toLowerCase()) {
        case 'fp_machine':
          return AppImages.fingetprintFloatingActionButtonIcon;
        case 'fp_scan':
          return AppImages.fingerprintQrcode;
        case 'fp_navigate' || 'custom_fp_navigate':
          return AppImages.fingerprintGps;
        case 'fp_bluetooth':
          return AppImages.fingerprintBlutooth;
        default:
          return AppImages.fingetprintFloatingActionButtonIcon;
      }
    }

    String? getFingerprintTime(String? time, bool? isIn) {
      // Check if the time is null or an empty string
      if (time == null || time.isEmpty) {
        return null;
      }

      try {
        // Parse the time string to a DateTime object
        DateTime dateTime = DateFormat("HH:mm:ss").parse(time);

        // Format the time as 'h:mm a' (e.g., 9:04 AM)
        String formattedTime = DateFormat('h:mm a').format(dateTime);

        // Return the string based on isIn value
        return "${isIn ?? true ? 'IN' : 'OUT'} $formattedTime";
      } catch (e) {
        return null;
      }
    }

    String? getBranchName() {
      return fingerprintDatetime.branchId;
    }

    return Container(
      width: LayoutService.getWidth(context),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.s16, vertical: AppSizes.s12),
      margin: const EdgeInsets.symmetric(vertical: AppSizes.s8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppSizes.s10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppSizes.s8),
                    width: AppSizes.s36,
                    height: AppSizes.s36,
                    child: Image.asset(isIn == true
                        ? AppImages.fingerprintIn
                        : AppImages.fingerprintOut)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (getFingerprintTime(fingerprintDatetime.time, isIn) !=
                        null)
                      AutoSizeText(
                        getFingerprintTime(fingerprintDatetime.time, isIn)!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: AppSizes.s14,
                            color: Colors.black),
                      ),
                    if (getBranchName() != null)
                      AutoSizeText(
                        getBranchName()!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          height: 1.3,
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSizes.s6),
              width: AppSizes.s26,
              height: AppSizes.s26,
              child: Image.asset(
                getFingerprintImageDependsOnType(
                    fingerprintType: fingerprintDatetime.type ?? ''),
                color: Colors.black,
              )),
          if (fingerprintDatetime.isOffline == true)
            Container(
                margin: const EdgeInsets.symmetric(horizontal: AppSizes.s6),
                width: AppSizes.s26,
                height: AppSizes.s26,
                child: Image.asset(
                  AppImages.fingerprintOffline,
                  color: Colors.black,
                )),
        ],
      ),
    );
  }
}
