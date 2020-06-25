import 'dart:io';
import 'dart:convert';
import 'dart:async';


class ConvertType {

  static Future<String> audioToBase64(String path) async {
    // load file

    var byteList    = await File(path).readAsBytes();
    String b64audio = base64.encode(byteList);

    return b64audio;
  }
}
