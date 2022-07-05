import 'dart:convert';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:universal_html/html.dart' as html;

class DownloadService {
  void run(Uint8List bytes) async {
    // Encode our uilist in base64

    // add the name
    final name = DateTime.now().microsecondsSinceEpoch.toString();

    await FileSaver.instance.saveFile(
      name,
      bytes,
      'png',
      mimeType: MimeType.PNG,
    );

    return;
  }
}
