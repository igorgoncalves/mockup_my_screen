import 'package:flutter/material.dart';
import 'package:mockup_my_screen/services/download.dart';
import 'package:mockup_my_screen/services/upload_file.dart';
import 'package:mockup_my_screen/widgets/toolbar.dart';
import 'package:provider/provider.dart';

import 'package:screenshot/screenshot.dart';

import '../widgets/mockup_image.dart';
import 'options_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ImageProvider? image;
  ScreenshotController screenshotController = ScreenshotController();
  late UploadService _uploadService;
  late DownloadService _downloadService;
  late OptionsController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = Provider.of<OptionsController>(context);
    _uploadService = Provider.of<UploadService>(context);
    _downloadService = Provider.of<DownloadService>(context);
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
                  child: Center(
                    child: Screenshot(
                      controller: screenshotController,
                      child: MokupImage(
                        asset: controller.image,
                        device: controller.deviceInfo,
                        orientation: controller.orientation,
                        alignment: controller.alignment,
                        fit: controller.fit,
                        onUpload: onUpload,
                      ),
                    ),
                  ),
                ),
                ToolbarWidget(
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
