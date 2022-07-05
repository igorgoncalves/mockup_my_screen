import 'dart:convert';

import 'dart:typed_data';

import 'package:universal_html/html.dart';

class DownloadService {
  void run(Uint8List uilist) {
    // Encode our uilist in base64
    final _base64 = base64Encode(uilist);
    // Create the link with the file
    final fileName = DateTime.now().microsecondsSinceEpoch.toString() + '.png';

    AnchorElement(
        href: 'data:application/octet-stream;charset=utf-16le;base64,$_base64')
      ..setAttribute("download", fileName)
      ..target = 'blank'
      ..click();

    return;
  }
}
