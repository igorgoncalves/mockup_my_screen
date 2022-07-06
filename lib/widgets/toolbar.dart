import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:mockup_my_screen/pages/options_controller.dart';
import 'package:provider/provider.dart';

class ToolbarWidget extends StatelessWidget {
  const ToolbarWidget({
    Key? key,
    required this.onUpload,
    required this.onSave,
  }) : super(key: key);

  final void Function() onUpload;
  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OptionsController>(context);

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
                itemHeight: 50,
                items: controller.devicesMenuItens,
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
                items: controller.fitMenuItens,
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
                items: controller.alignMenuItens,
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
                items: controller.orientationsMenuItens,
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
