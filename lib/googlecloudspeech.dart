import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:googlecloudspeech/utils.dart';

/// This resource represents a long-running operation that is the result of a network API call.
class GoogleSTTOperations {

  static Future<Map<String, dynamic>> v1_list(Map<String, String> config, String api_key) async {
    /// GET https://speech.googleapis.com/v1/operations

    /// Request URL
    String baseUrl              = 'https://speech.googleapis.com/v1/operations';
    String operationsListUrl    = baseUrl + '?key=' + api_key;
    Map<String, String> headers = {};

    final http.Response response = await http.get(operationsListUrl);

    return json.decode(response.body);
  }

  static Future<void> v1_get() async {
    /// GET https://speech.googleapis.com/v1/operations/{name=**}

    throw Exception('Not implemented');
  }
}

/// Convert speech to text
class GoogleSTTSpeech {

  /// Performs asynchronous speech recognition. The results are received from the
  /// google.longrunning.Operations interface
  static Future<void> v1_longrunningrecognize() async {
    /// POST https://speech.googleapis.com/v1/speech:longrunningrecognize

    throw Exception('Not implemented');
  }

  /// Performs synchronous speech recognition. The results are received after all
  /// the audio has been sent and processed.
  static Future<Map<String, dynamic>> v1_recognize(
      Map<String, String> config,
      String api_key,
      String audio_type,
      String audio_src,
      ) async {
    /// POST https://speech.googleapis.com/v1/speech:recognize
    /// audio_type can be either 'file_path' or 'base64'

    String content = '';

    if (audio_type == 'file_path') {
      content = await ConvertType.audioToBase64(audio_src);
    } else {
      content = audio_src;
    }

    print("----- CONTENT -----");
    print(content);
    print("-------------------");

    /// Request URL
    String baseUrl              = 'https://speech.googleapis.com/v1/speech:recognize';
    String speechUrl            = baseUrl + '?key=' + api_key;
    Map<String, String> headers = {};

    if (config.isEmpty) {
      config['languageCode'] = 'en-US';
    }

    http.Response response = await http.post(
        speechUrl,
        headers : <String, String>{},
        body    : jsonEncode(<String, dynamic>{
          'audio': {
            'content' : content
          },
          'config': config
        })
    );

    return json.decode(response.body);
  }
}
