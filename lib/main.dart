import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notii/message.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Firebase Notifications'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Message _msg;

  _getToken() {
    _firebaseMessaging.getToken().then((value) {
      print(value);
    });
  }

  _configureFirebaseListener() {
    _firebaseMessaging.configure(
      onLaunch: (message) async {
        print('onLaunch:' + message.toString());
        _setMessage(message);
      },
      onMessage: (message) async {
        print('onMessage:' + message.toString());
        _setMessage(message);
      },
      onResume: (message) async {
        print('onResume:' + message.toString());
        _setMessage(message);
      },
    );
  }

  _setMessage(message) {
    setState(() {
      _msg = Message(message['data']['title'], message['data']['body'],
          message['data']['message']);
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getToken();
    _configureFirebaseListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.blue,
                title: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      _msg != null && _msg.message != null
                          ? Text(
                              'Title: ' + _msg.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            )
                          : Text(
                              'Title: ' + "",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                      SizedBox(height: 15),
                      _msg != null && _msg.message != null
                          ? Text(
                              'Body: ' + _msg.body,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          : Text(
                              'Body: ' + "",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                      SizedBox(height: 15),
                      _msg != null && _msg.message != null
                          ? Text(
                              'Message: ' + _msg.message,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          : Text(
                              'Message: ' + "",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}
