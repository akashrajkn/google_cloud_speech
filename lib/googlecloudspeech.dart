import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

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
      String b64_audio
      ) async {
    /// POST https://speech.googleapis.com/v1/speech:recognize

    /// Request URL
    String baseUrl              = 'https://speech.googleapis.com/v1/speech:recognize';
    String speechUrl    = baseUrl + '?key=' + api_key;
    Map<String, String> headers = {};

    http.Response response = await http.post(
        speechUrl,
        headers: <String, String>{

        },
        body: jsonEncode(<String, dynamic>{
          'audio': {
            'content' : b64_audio
          },
          'config': {
            'encoding': 'FLAC',
            'sampleRateHertz': 16000,
            'languageCode': 'en-US'
          }
        })
    );

    return json.decode(response.body);
  }
}
