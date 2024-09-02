import 'package:flutter/material.dart';
import '../general_services/prevent_screenshot_screenrecording.service.dart';

class PreventScreenShotAndScreenRecordingWidget extends StatefulWidget {
  final Widget child;

  const PreventScreenShotAndScreenRecordingWidget(
      {super.key, required this.child});

  @override
  PreventScreenShotAndScreenRecordingWidgetState createState() =>
      PreventScreenShotAndScreenRecordingWidgetState();
}

class PreventScreenShotAndScreenRecordingWidgetState
    extends State<PreventScreenShotAndScreenRecordingWidget> {
  @override
  void initState() {
    super.initState();
    PreventScreenShotAndScreenRecording.enable();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
