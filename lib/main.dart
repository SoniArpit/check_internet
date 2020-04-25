import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // void checkConn() async {
  //   // simple way to chack easy-pizzy way methid 1
  //   // try {
  //   //   final result = await InternetAddress.lookup("google.com");
  //   //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //   //     print("Connected!!");
  //   //   }
  //   // } on SocketException catch (_) {
  //   //   print("Not connected!!");
  //   // }

  //   // now using connection  method 2
  //   var connResult = await (Connectivity().checkConnectivity());
  //   if (connResult == ConnectivityResult.none) {
  //     print("Internet not connected!!");
  //   } else if (connResult == ConnectivityResult.mobile) {
  //     print("Mobile internet connected!!");
  //   } else if (connResult == ConnectivityResult.wifi) {
  //     print("WiFi internet connected!!");
  //   }
  // }

  // method 3
  StreamSubscription connectivityStream;
  ConnectivityResult oldConn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectivityStream = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult nowConn) {
      if (nowConn == ConnectivityResult.none) {
        print("Not connected!!");
      } else if (oldConn == ConnectivityResult.none) {
        // print("Connected");
        if (nowConn == ConnectivityResult.mobile) {
          print("Mobile internet");
        } else if (nowConn == ConnectivityResult.wifi) {
          print("Wifi internet");
        }
      }
      oldConn = nowConn;
    });
  }

  @override
  void dispose() {
    super.dispose();
    connectivityStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Internet Check")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Internet Check"),
            RaisedButton(
              onPressed: () => {}, //checkConn,
              child: Text("Check!"),
            ),
          ],
        ),
      ),
    );
  }
}
