import 'dart:async';
import 'package:flutter/foundation.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription _subscriber;
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscriber = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscriber.cancel();
    super.dispose();
  }
}
