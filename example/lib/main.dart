import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:googlecloudspeech/googlecloudspeech.dart';
import 'package:flutter/services.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _apiKey = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> getListOfOperations() async {

    Map<String, dynamic> responseBody = await GoogleSTTOperations.v1_list({}, _apiKey);

    print("----------");
    print(responseBody);
    print("----------");

    // await GoogleSTTOperations.v1_get();
  }

  Future<void> speechToText() async {

    try {
      // This is an example asset file. Replace this with a file on the device
      var bytes            = await rootBundle.load('assets/example_file.flac');
      String base64audio   = base64.encode(Uint8List.view(bytes.buffer));

      Map<String, dynamic> response = await GoogleSTTSpeech.v1_recognize({}, _apiKey, base64audio);

      print("-------------------------------");
      print(response['results']['transcript']);
      print("-------------------------------");

    } catch (e) {
      print(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      home                       : Scaffold(
        appBar : AppBar(title: const Text('google_cloud_speech example'),),
        body   : Center(

            child : Column(
              mainAxisAlignment : MainAxisAlignment.center,

              children : <Widget>[
                Container(
                  height : 60,
                  width  : 270,
                  decoration : BoxDecoration(
                    borderRadius : BorderRadius.circular(10.0),
                    color        : Colors.white,
                  ),

                  child : MaterialButton(
                    highlightColor : Colors.grey[600],
                    shape          : RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),

                    child : Text('Operations List', style : TextStyle(fontSize : 25, fontWeight : FontWeight.bold, color : Colors.grey[500])),
                    onPressed: () { speechToText(); },
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
