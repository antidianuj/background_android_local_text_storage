import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:permission_handler/permission_handler.dart';







import 'package:csv/csv.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

Timer timer;
int y = 0;
var dio = Dio();

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _integ=0;

  @override
  void initState() {

    super.initState();

    timer = Timer.periodic(Duration(seconds: 5), (Timer t)
    async {
      if (_integ == 0) {
        WidgetsFlutterBinding.ensureInitialized();
        setState(() {
          _integ = _integ + 1;
        });
      }
      else
      {
        setState(() {
          _integ = _integ + 1;
        });

        print("Done!!");


      }
    }
    );



    // Timer(Duration(microseconds: 1), (){
    //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
    //   //     TutorialHome()));
    //   print("Hi");
    // });

  }
  @override
  void dispose() {
    print("Ok...");
    timer?.cancel();

    super.dispose();

  }


  void startServiceInPlatform() async {
    if(Platform.isAndroid){
      var methodChannel = MethodChannel("com.retroportalstudio.messages");
      String data = await methodChannel.invokeMethod("startService");
      debugPrint(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: RaisedButton(
            child: Text("Start Background"),
            onPressed: () async{
                  startServiceInPlatform();

            }

        ),
      ),
    );
  }
  void getPermission() async {
    print("getPermission");
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  }


