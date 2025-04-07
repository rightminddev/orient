import 'package:hive/hive.dart';

abstract class DBHiveService {
  static const String fingerprintsBoxName = 'fingerprints';

  static Future<void> saveFingerprint(
      Map<String, dynamic> fingerprintData) async {
    final box = await Hive.openBox(fingerprintsBoxName);
    await box.add(fingerprintData);
  }

  static Future<List<Map<String, dynamic>>> getSavedFingerprints() async {
    final box = await Hive.openBox(fingerprintsBoxName);
    return box.values.cast<Map<String, dynamic>>().toList();
  }

  static Future<void> clearSavedFingerprints() async {
    final box = await Hive.openBox(fingerprintsBoxName);
    await box.clear();
  }
}
