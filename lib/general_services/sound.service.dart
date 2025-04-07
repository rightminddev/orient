import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class SoundService {
  static Soundpool? _pool;
  static int? _notificationSoundId;
  static Future init({required String soundFilePath}) async {
    try {
      _pool = Soundpool.fromOptions();
      _notificationSoundId =
          await rootBundle.load(soundFilePath).then((ByteData soundData) {
        return _pool?.load(soundData);
      });
    } catch (err) {
      debugPrint('Display Sound Error: ${err.toString()}');
    }
  }

  static Future play() async {
    if (_notificationSoundId == null || _pool == null) {
      return;
    }
    await _pool?.stop(_notificationSoundId!);
    await _pool?.play(_notificationSoundId!);
  }
}
