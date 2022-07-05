import 'package:device_frame/device_frame.dart';
import 'package:flutter/widgets.dart';

class Controller extends ChangeNotifier {
  DeviceInfo deviceInfo = Devices.ios.iPhone13;
  bool safeArea = false;
  ImageProvider? image;
  Orientation orientation = Orientation.portrait;
  BoxFit fit = BoxFit.contain;
  Alignment alignment = Alignment.topCenter;

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
