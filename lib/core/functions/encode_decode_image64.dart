import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

String convertIntoBase64(File file) {
  List<int> imageBytes = file.readAsBytesSync();
  String base64File = base64Encode(imageBytes);
  return base64File;
}

Uint8List imageBase64Decode(String base64String) {
  return base64Decode(base64String);
}

List<String> convertFilesIntoBase64(List<File> files) {
  List<String> base64Files = [];
  files.forEach((file) {
    List<int> imageBytes = file.readAsBytesSync();
    base64Files.add(base64Encode(imageBytes));
  });
  return base64Files;
}
