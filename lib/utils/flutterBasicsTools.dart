import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class FlutterBasicsTools {
  Future storeImage(Uint8List imageBytes, String fileName) async {
    try {
      // Get the app's document directory
      final Directory directory = await getApplicationDocumentsDirectory();
      final String path = '${directory.path}/$fileName';

      // Write the image data to a file
      final File file = File(path);
      await file.writeAsBytes(imageBytes);
    } catch (e) {
      log("Error storing image: $e");
    }
  }

  Future<Uint8List?> readImage(String fileName) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String path = '${directory.path}/$fileName';
      final File file = File(path);

      if (await file.exists()) {
        return await file.readAsBytes();
      } else {
        log("File does not exist");
        return null;
      }
    } catch (e) {
      log("Error reading image: $e");
      return null;
    }
  }
}
