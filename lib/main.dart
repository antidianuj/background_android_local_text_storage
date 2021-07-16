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
        await csvgenerator("1","2",3,"4");

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
  Future<int> _readIndicator() async {
    String text;
    int indicator;
    try {
      String path = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);
      String fullPath = "$path/Beacons.csv";
      final File file = File(fullPath);
      text = await file.readAsString();
      // debugPrint("A file has been read at ${directory.path}");
      indicator = 1;
    } catch (e) {
      debugPrint("Couldn't read file");
      indicator = 0;
    }
    return indicator;
  }

  void csvgenerator(String uname, String beaconid_others, double distance,String u_beaconid) async {
    String dir = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
    print("dir $dir");
    String file = "$dir";

    var f = await File(file + "/Beacons.csv");
    int dd = await _readIndicator();
    if (dd == 1) {
      if (y == 0) {
        y = 1;
        print("**********************************************************");
        print("There is file!");
        print("**********************************************************");
        final csvFile = new File(file + "/Beacons.csv").openRead();
        var dat = await csvFile
            .transform(utf8.decoder)
            .transform(
          CsvToListConverter(),
        )
            .toList();

        List<List<dynamic>> rows = [];

        List<dynamic> row = [];
        for (int i = 0; i < dat.length; i++) {
          List<dynamic> row = [];
          row.add(dat[i][0]);
          row.add(dat[i][1]);
          row.add(dat[i][2]);
          row.add(dat[i][3]);
          row.add(dat[i][4]);
          row.add(dat[i][5]);


          print(
              "```````````````````````````````````````````````````````````````````````object```````````````````````````````````````````````````````````````````````");
          print(dat[i][0]);
          print(dat[i][1]);
          rows.add(row);
        }
        // for (int i = 0; i < dat.length; i++) {
        //   List<dynamic> row = [];
        //   row.add(dat[i][0]);
        //   row.add(dat[i][1]);
        //   row.add(dat[i][2]);
        //   row.add(dat[i][3]);
        //   row.add(dat[i][4]);
        //   rows.add(row);
        // }
        var now = new DateTime.now();
        var formatter = new DateFormat('yyyy-MM-dd');
        String time = DateFormat('kk:mm:s').format(now);
        String date = formatter.format(now);
        // row.add(date);
        // row.add(time);
        // row.add(uuid);
        // row.add(distance);
        // rows.add(row);
        // await Future.delayed(Duration(seconds: 10));
        // String csver = const ListToCsvConverter().convert(rows);
        f.writeAsString("$uname,$beaconid_others,$date,$time,$distance,$u_beaconid" + '\n',
            mode: FileMode.append, flush: true);
        // for (int i = 0; i < 1000; i++) {}
      } else {
        // final cron = Cron()
        //   ..schedule(Schedule.parse('*/1 * * * * *'), () {
        //     print(DateTime.now());
        //   });
        await Future.delayed(Duration(seconds: 100));
        // List<List<dynamic>> rows = [];

        // List<dynamic> row = [];
        var now = new DateTime.now();
        var formatter = new DateFormat('yyyy-MM-dd');
        var time = DateFormat('HH:mm:ss').format(now);
        var date = formatter.format(now);
        // row.add(date);
        // row.add(time);
        // row.add(uuid);
        // row.add(distance);

        // rows.add(row);

        // String csv = const ListToCsvConverter().convert(rows);
        // await Future.delayed(Duration(seconds: 10));
        f.writeAsString("$uname,$beaconid_others,$date,$time,$distance,$u_beaconid" + '\n',
            mode: FileMode.append, flush: true);
      }
    } else {
      // List<List<dynamic>> rows = [];

      // List<dynamic> row = [];
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      var time = DateFormat('HH:mm:ss').format(now);
      var date = formatter.format(now);
      // row.add(date);
      // row.add(time);
      // row.add(uuid);
      // row.add(distance);

      // rows.add(row);

      // String csv = const ListToCsvConverter().convert(rows);
      // await Future.delayed(Duration(seconds: 10));
      f.writeAsString("token,beaconid_others,date,time,distance,u_beaconid" + '\n',
          mode: FileMode.append, flush: true);
      // for (int i = 0; i < 1000; i++) {}
    }
  }
  }


