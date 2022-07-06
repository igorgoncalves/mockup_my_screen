import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

class MokupPhone extends StatelessWidget {
  const MokupPhone({
    Key? key,
    required this.onUpload,
    required this.device,
    required this.orientation,
  }) : super(key: key);

  final void Function() onUpload;
  final DeviceInfo device;
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return DeviceFrame(
      device: device,
      isFrameVisible: true,
      orientation: orientation,
      screen: Flexible(
        child: ElevatedButton(
          onPressed: onUpload,
          child: const Text("Upload Image"),
        ),
      ),
    );
  }
}
