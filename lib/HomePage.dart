import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  static const platformMethodChannel = const MethodChannel('testMethodChanel');
  String nativeMessage = '';
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 200.0),
            child: new Text(
              'Press button to call platform method channel',
              style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18.0),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 102.0),
            child: new RaisedButton(
              child: new Text('Click Me'),
              onPressed: () => nativePlatformCall(),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 102.0),
            child: new Text(
              nativeMessage,
              style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 23.0),
            ),
          )
        ],
      ),
    );
  }

  Future<Null> nativePlatformCall() async {
    String _message;
    try {
      final String result = await platformMethodChannel.invokeMethod('getDateTime');
      _message = result;
      print(result);
    } on PlatformException catch (e) {
      _message = "Exception to call platform method channel: ${e.message}.";
    }
    setState(() {
      nativeMessage = _message;
    });
    Timer(Duration(seconds: 10), () {
      nativePlatformCall();
    });
  }
}
