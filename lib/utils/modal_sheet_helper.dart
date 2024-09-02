import '../constants/app_sizes.dart';
import '../models/operation_result.model.dart';
import 'package:flutter/material.dart';

abstract class ModalSheetHelper {
  static Future<OperationResult<Map<String, dynamic>>?> showModalSheet(
      {required BuildContext context,
      required Widget modalContent,
      required double height,
      required String title}) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(AppSizes.s26)),
        ),
        builder: (BuildContext context) => AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: height + MediaQuery.of(context).viewInsets.bottom,
              color: Colors.white,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Padding(
                  padding: const EdgeInsets.all(AppSizes.s16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Modal Sheet Holder
                        Container(
                          height: AppSizes.s5,
                          width: AppSizes.s80,
                          decoration: BoxDecoration(
                              color: const Color(0xffB9C0C9),
                              borderRadius: BorderRadius.circular(AppSizes.s4)),
                        ),
                        gapH24,
                        // Modal Sheet title
                        Center(
                          child: Text(title,
                              style: Theme.of(context).textTheme.headlineLarge),
                        ),
                        gapH26,
                        // Modal Sheet content
                        Expanded(
                            child: SingleChildScrollView(child: modalContent))
                      ]),
                ),
              ),
            ));
  }
}
