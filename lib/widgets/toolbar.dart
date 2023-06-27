import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mockup_my_screen/pages/options_controller.dart';
import 'package:provider/provider.dart';

import 'custom_dropdown.dart';

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
        height: double.infinity,
        width: 400,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("logo.svg"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Checkbox(
                            value: controller.safeArea,
                            onChanged: (value) =>
                                controller.toogleSafeArea(value!),
                          ),
                          const Text("Safe Area"),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Checkbox(
                            value: controller.scroll,
                            onChanged: (value) =>
                                controller.toogleScroll(value!),
                          ),
                          const Text("Scroll")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CustomDropdown<DeviceInfo>(
                  labelText: "Device",
                  items: controller.devicesMenuItens,
                  onChanged: (DeviceInfo? item) {
                    controller.changeDevice(item!);
                  },
                  value: controller.deviceInfo,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CustomDropdown<BoxFit>(
                  labelText: "Box Fit",
                  items: controller.fitMenuItens,
                  onChanged: (BoxFit? item) {
                    controller.changeFit(item!);
                  },
                  value: controller.fit,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CustomDropdown<Alignment>(
                  labelText: "Alignment",
                  items: controller.alignMenuItens,
                  onChanged: (Alignment? item) {
                    controller.changeAligment(item!);
                  },
                  value: controller.alignment,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CustomDropdown<Orientation>(
                  labelText: "Orientation",
                  items: controller.orientationsMenuItens,
                  onChanged: (Orientation? item) {
                    controller.changeOrientation(item!);
                  },
                  value: controller.orientation,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          textStyle: const TextStyle(color: Colors.black),
                          side: const BorderSide(
                            width: 3.0,
                          ),
                        ),
                        onPressed: onUpload,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Upload Image",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    Flexible(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        onPressed: onSave,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Mockup me!"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
