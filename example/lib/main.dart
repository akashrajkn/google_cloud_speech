import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:googlecloudspeech/googlecloudspeech.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // ADD API_KEY HERE
  String _apiKey = '';

  String _audioPath;
  String _response;

  @override
  void initState() {
    super.initState();

    _audioPath = '';
    _response  = '';
  }

  Future<void> getListOfOperations() async {

    Map<String, dynamic> responseBody = await GoogleSTTOperations.v1_list({}, _apiKey);

    print("---------- RESPONSE ----------");
    print(responseBody);
    print("------------------------------");
  }

  Future<void> speechToText() async {

    try {
//      // This is an example asset file. Replace this with a file on the device
//      var bytes            = await rootBundle.load('assets/example_file.flac');
//      String base64audio   = base64.encode(Uint8List.view(bytes.buffer));

      // NOTE: Currently config dictionary supports only file types 'flac' or 'wav'
      Map<String, dynamic> response = await GoogleSTTSpeech.v1_recognize({}, _apiKey, 'file_path', _audioPath);

      print("------ RESPONSE ------");
      print(response);
      print("----------------------");

      setState(() {
        _response = response.toString();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _openFileExplorer() async {

    try {
      String path = await FilePicker.getFilePath(type: FileType.audio,);

      setState(() {
        _audioPath = path;
      });

    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
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

                    child : Text('Select File', style : TextStyle(fontSize : 25, fontWeight : FontWeight.bold, color : Colors.grey[500])),
                    onPressed: _openFileExplorer,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),

                  child: Text(_audioPath, style: TextStyle(fontSize: 12))
                ),
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

                    child : Text('Speech 2 Text', style : TextStyle(fontSize : 25, fontWeight : FontWeight.bold, color : Colors.grey[500])),
                    onPressed: () { speechToText(); },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),

                  child: Text(_response, style : TextStyle(fontSize: 12))
                )
              ],
            )
        ),
      ),
    );
  }
}
