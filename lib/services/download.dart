import 'dart:convert';
import 'dart:typed_data';

import 'package:universal_html/html.dart' as html;

class DownloadService {
  void run(Uint8List uilist) {
    // Encode our uilist in base64
    final _base64 = base64Encode(uilist);
    // Create the link with the file
    final anchor = html.AnchorElement(
        href: 'data:application/octet-stream;base64,$_base64')
      ..target = 'blank';
    // add the name
    anchor.download = DateTime.now().microsecondsSinceEpoch.toString() + '.png';

    // trigger download
    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
    return;
  }
}
