import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class UrlLauncherServiceEx {
  static Future<void> launch(
      {required BuildContext context,
      required String url,
      Function? methodCalledWhenLaunchFailed,
      bool ignoreError = true,
      String? errorMessage,
      LaunchMode mode = LaunchMode.platformDefault}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: mode);
    } else {
      if (!ignoreError || errorMessage != null) {
        if (methodCalledWhenLaunchFailed != null) {
          methodCalledWhenLaunchFailed();
        }
      }
    }
  }
}
