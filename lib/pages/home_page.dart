import 'dart:async';
import 'dart:ui' as ui;
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:mockup_my_screen/services/download.dart';
import 'package:mockup_my_screen/services/upload_file.dart';
import 'package:provider/provider.dart';

import 'package:screenshot/screenshot.dart';

import 'controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ImageProvider? image;
  ScreenshotController screenshotController = ScreenshotController();
  final _uploadService = UploadService();
  final _downloadService = DownloadService();
  late Controller controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = Provider.of<Controller>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(64.0),
                  child: MockupLayer(
                    screenshotController: screenshotController,
                    image: controller.image,
                    device: controller.deviceInfo,
                    orientation: controller.orientation,
                    alignment: controller.alignment,
                    fit: controller.fit,
                    onUpload: onUpload,
                  ),
                ),
                ToolbarLayer(
                  onSave: onSave,
                  onUpload: onUpload,
                ),
              ],
            );
          }),
    );
  }

  void onSave() async {
    screenshotController
        .capture(
          pixelRatio: 3.5,
        )
        .then(
          (screenshot) => _downloadService.run(screenshot!),
        );
  }

  void onUpload() async {
    final file = await _uploadService.run();
    if (file != null) {
      controller.changeImage(file.image);
    }
  }
}

class ToolbarLayer extends StatelessWidget {
  const ToolbarLayer({
    Key? key,
    required this.onUpload,
    required this.onSave,
  }) : super(key: key);

  final void Function() onUpload;
  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);

    final devicesMenuItens = [
      for (var item in Devices.all)
        DropdownMenuItem(
          child: Text(item.name),
          value: item,
        )
    ];

    final orientationsMenuItens = [
      for (var item in Orientation.values)
        DropdownMenuItem(
          child: Text(item.name),
          value: item,
        )
    ];

    const alignMap = <String, Alignment>{
      "center": Alignment.center,
      "centerLeft": Alignment.centerLeft,
      "centerRight": Alignment.centerRight,
      "topCenter": Alignment.topCenter,
      "topLeft": Alignment.topLeft,
      "topRight": Alignment.topRight,
      "bottomCenter": Alignment.bottomCenter,
      "bottomLeft": Alignment.bottomLeft,
      "bottomRight": Alignment.bottomRight,
    };

    final alignMenuItens = [
      for (var item in alignMap.entries)
        DropdownMenuItem(
          child: Text(item.key),
          value: item.value,
        )
    ];

    final fitMenuItens = [
      for (var item in BoxFit.values)
        DropdownMenuItem(
          child: Text(item.name),
          value: item,
        )
    ];

    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        color: Colors.white10.withAlpha(230),
        width: 400,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DropdownButton(
                isExpanded: true,
                hint: const Text("Device"),
                items: devicesMenuItens,
                onChanged: (DeviceInfo? item) {
                  controller.changeDevice(item!);
                },
                value: controller.deviceInfo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DropdownButton<BoxFit>(
                isExpanded: true,
                hint: const Text("Box Fit"),
                items: fitMenuItens,
                onChanged: (BoxFit? item) {
                  controller.changeFit(item!);
                },
                value: controller.fit,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DropdownButton<Alignment>(
                isExpanded: true,
                hint: const Text("Box Fit"),
                items: alignMenuItens,
                onChanged: (Alignment? item) {
                  controller.changeAligment(item!);
                },
                value: controller.alignment,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DropdownButton<Orientation>(
                isExpanded: true,
                hint: const Text("Orientation"),
                items: orientationsMenuItens,
                onChanged: (Orientation? item) {
                  controller.changeOrientation(item!);
                },
                value: controller.orientation,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Checkbox(
                    value: controller.safeArea,
                    onChanged: (value) => controller.toogleSafeArea(value!),
                  ),
                  const Text("Safe Area")
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: onUpload,
                    child: const Text("Upload Image"),
                  ),
                ),
                const SizedBox(width: 40),
                Flexible(
                  child: ElevatedButton(
                    onPressed: onSave,
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MockupLayer extends StatelessWidget {
  const MockupLayer({
    Key? key,
    required this.screenshotController,
    required this.image,
    required this.device,
    required this.onUpload,
    required this.orientation,
    required this.fit,
    required this.alignment,
  }) : super(key: key);

  final ScreenshotController screenshotController;
  final ImageProvider<Object>? image;
  final DeviceInfo device;
  final Orientation orientation;
  final void Function() onUpload;
  final BoxFit fit;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Screenshot(
        controller: screenshotController,
        child: MokupImage(
          asset: image,
          device: device,
          onUpload: onUpload,
          orientation: orientation,
          fit: fit,
          alignment: alignment,
        ),
      ),
    );
  }
}

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

  // Future<ui.Image> _getImage(ImageProvider provider) {
  //   Completer<ui.Image> completer = Completer<ui.Image>();
  //   provider
  //       .resolve(const ImageConfiguration())
  //       .addListener(ImageStreamListener((info, synchronousCall) {
  //     return completer.complete(info.image);
  //   }));
  //   return completer.future;
  // }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);
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
