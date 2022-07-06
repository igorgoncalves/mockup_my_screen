import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

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

class OptionsController extends ChangeNotifier {
  DeviceInfo deviceInfo = Devices.ios.iPhone13;
  bool safeArea = false;
  ImageProvider? image;
  Orientation orientation = Orientation.portrait;
  BoxFit fit = BoxFit.contain;
  Alignment alignment = Alignment.topCenter;

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

  changeFit(BoxFit value) {
    fit = value;
    notifyListeners();
  }

  changeAligment(Alignment value) {
    alignment = value;
    notifyListeners();
  }

  changeOrientation(Orientation value) {
    orientation = value;
    notifyListeners();
  }

  changeDevice(DeviceInfo value) {
    deviceInfo = value;
    notifyListeners();
  }

  changeImage(ImageProvider value) {
    image = value;
    notifyListeners();
  }

  toogleSafeArea(bool value) {
    safeArea = value;
    notifyListeners();
  }

  @override
// ignore: unnecessary_overrides
  void notifyListeners() {
    super.notifyListeners();
  }
}
