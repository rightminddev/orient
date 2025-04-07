import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../../general_services/app_config.service.dart';
import '../../../general_services/connections.service.dart';
import '../../../general_services/location.service.dart';
import '../../../general_services/settings.service.dart';
import '../../../routing/app_router.dart';

class OfflineViewModel with ChangeNotifier {
  final List<String> _usersFingerprints = [];

  List<String> get usersFingerprints => _usersFingerprints;

  void initialize({required BuildContext ctx}) async {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(ctx, listen: false);
    Map<dynamic, dynamic> fingerprints = appConfigServiceProvider
        .getSettings(type: SettingsType.userSettings)
        ?.toJson()['av_fingerprint'];
    fingerprints.forEach((key, value) {
      if (value == 'active_all' || value == 'active_some') {
        _usersFingerprints.add(key);
      }
    });

    ConnectionsService.connectionStream.listen((result) {
      // Handle connectivity changes
      if (result.contains(ConnectivityResult.none)) {
        // return to the page that running before connection failed !!
        Navigator.pop(ctx);
      }
    });
  }

  qrCode({required BuildContext ctx}) =>
      ctx.goNamed(AppRoutes.qrcodeScreen.name);

  Future<LocationData?> gps() async {
    return LocationService.getLocation();
  }
}
