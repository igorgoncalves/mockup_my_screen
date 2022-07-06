import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:mockup_my_screen/pages/options_controller.dart';
import 'package:provider/provider.dart';

class MokupImage extends StatelessWidget {
  const MokupImage({
    Key? key,
    required this.asset,
    required this.device,
    required this.orientation,
    required this.onUpload,
    required this.fit,
    required this.alignment,
  }) : super(key: key);

  final ImageProvider? asset;
  final DeviceInfo device;
  final void Function() onUpload;
  final Orientation orientation;

  final BoxFit fit;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OptionsController>(context);
    Widget element = asset == null
        ? ElevatedButton.icon(
            icon: const Icon(
              Icons.add_a_photo_outlined,
              size: 64,
            ),
            label: const Text("Add Image", textScaleFactor: 3.5),
            onPressed: onUpload,
          )
        : Image(
            image: asset!,
            fit: fit,
            alignment: alignment,
          );

    if (controller.safeArea) {
      element = SafeArea(child: element);
    }

    return DeviceFrame(
      device: device,
      isFrameVisible: true,
      orientation: orientation,
      screen: element,
    );
  }
}
