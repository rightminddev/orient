import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_sizes.dart';
import '../view_models/offline_viewmodel.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OfflineViewModel(),
      child: Scaffold(
        body: Consumer<OfflineViewModel>(
          builder: (context, viewModel, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (viewModel.usersFingerprints.isNotEmpty)
                  ListView.builder(
                    itemCount: viewModel.usersFingerprints.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      IconData icon;
                      Function()? function;
                      String hero;

                      switch (viewModel.usersFingerprints[index]) {
                        case 'fp_scan':
                          icon = Icons.qr_code;
                          function = viewModel.qrCode(ctx: context);
                          hero = 'QR';
                          break;
                        case 'fp_wifi':
                          icon = Icons.wifi;
                          hero = 'wifi';
                          break;
                        case 'fp_navigate':
                          icon = Icons.gps_fixed;
                          function = () => viewModel.gps();
                          hero = 'gps';
                          break;
                        case 'fp_bluetooth':
                          icon = Icons.bluetooth;
                          hero = 'bluetooth';
                          break;
                        default:
                          icon = Icons.add;
                          hero = 'undefined';
                          break;
                      }

                      return _widget(icon: icon, onPress: function, hero: hero);
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _widget(
          {required IconData icon,
          Function()? onPress,
          required String hero}) =>
      Padding(
        padding: const EdgeInsets.all(AppSizes.s15),
        child: Row(
          children: [
            Expanded(
              child: FloatingActionButton(
                heroTag: hero,
                onPressed: onPress,
                child: Icon(icon),
              ),
            ),
          ],
        ),
      );
}
