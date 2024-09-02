// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';

// import 'app_config.service.dart';

// class RecorderLogic {
//   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   bool _recorderReady = false;

//   /// Initialize the recorder
//   Future<void> initRecorder() async {
//     // Request microphone permission
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw 'Microphone permission not granted';
//     }

//     // Open the recorder
//     await _recorder.openRecorder();
//     _recorderReady = true;

//     // Set recorder subscription duration
//     _recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
//   }

//   /// Start recording
//   Future<void> record() async {
//     if (!_recorderReady) return;

//     // Start recording to a file
//     await _recorder.startRecorder(
//       toFile: 'Audio',
//       codec: Codec.aacADTS,
//     );
//   }

//   /// Stop recording
//   Future<String?> stop(
//       {ValueNotifier<String>? notifier, required BuildContext context}) async {
//     if (!_recorderReady) return null;

//     // Stop the recorder and get the recorded file path
//     final path = await _recorder.stopRecorder();
//     if (path != null) {
//       Provider.of<AppConfigService>(context, listen: false).recordPath = path;
//       if (notifier != null) {
//         notifier.value = Random().nextInt(1000000).toString();
//       }
//     }
//     return path;
//   }

//   /// Delete the recorded file
//   Future<String?> deleteRecord(
//       {ValueNotifier<String>? notifier, required BuildContext context}) async {
//     return await stop(notifier: notifier, context: context);
//   }
// }
