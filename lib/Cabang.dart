import 'package:flutter/material.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'Recent.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Cabang extends StatefulWidget {
  @override
  _CabangState createState() => _CabangState();
}

class _CabangState extends State<Cabang> {
  List cabang = [];
  String jumlah = "99999";
  String last = "0";

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var refreshkey = GlobalKey<RefreshIndicatorState>();
  Future ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("http://192.168.43.184/nomAdmin/Api/getCabangOrder"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      cabang = json.decode(hasil.body);
    });
  }

  Future notif() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("http://192.168.43.184/nomAdmin/Api/getNewTrx"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      if (jumlah == "99999") {
        //j=5,l=5
        jumlah = hasil.body;
        last = hasil.body;
      } else {
        //j=5//l=6
        last = hasil.body;
        if (int.parse(jumlah) < int.parse(last)) {
          _showNotification();
        }
        jumlah = last;
      }
    });
  }

  Timer timer;

  @override
  void initState() {
    super.initState();
    this.ambildata();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
      ambildata();
      notif();
    });
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Cabang()),
        (Route<dynamic> route) => false);
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => SecondScreen(payload)),
    // );
  }

  Future _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    String trendingNewsId = '5';
    await flutterLocalNotificationsPlugin.show(
        0, 'Order Baru', 'Ada Order Baru gan', platformChannelSpecifics,
        payload: trendingNewsId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Cabang",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'ZCOOL QingKe HuangYou',
            color: Color.fromRGBO(243, 156, 18, 20),
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // drawer: Draw(),
      body: Container(
        decoration: new BoxDecoration(color: Colors.white),
        margin: EdgeInsets.only(top: 7),
        child: Column(
          children: <Widget>[
            Expanded(
              child: RefreshIndicator(
                key: refreshkey,
                onRefresh: refreshlist,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: cabang == null ? 0 : cabang.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Map menu = dataMenu[index];
                    return Column(
                      children: <Widget>[
                        FlatButton(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: 5, right: 5, top: 10, bottom: 10),
                                margin: EdgeInsets.only(right: 13),
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.black,
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(10.0)),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 7,
                                  // height: MediaQuery.of(context).size.height / 13,
                                  child: Text(
                                    (index + 1).toString() + "",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 40,
                                        color: Color.fromRGBO(243, 156, 18, 20),
                                        fontFamily: 'ZCOOL QingKe HuangYou'),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      cabang[index]['nama'].toString(),
                                      style: TextStyle(
                                        fontFamily: 'ZCOOL QingKe HuangYou',
                                        color: Colors.black,
                                        fontSize: 21,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      cabang[index]['alamat'].toString(),
                                      style: TextStyle(
                                        fontFamily: 'ZCOOL QingKe HuangYou',
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                              cabang[index]['jumlah'] == "0"
                                  ? Text("")
                                  : Container(
                                      padding: EdgeInsets.all(6),
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Color.fromRGBO(243, 156, 18, 20),
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(20.0)),
                                      ),
                                      child: Text(
                                        cabang[index]['jumlah'].toString(),
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontFamily:
                                                'ZCOOL QingKe HuangYou'),
                                      ),
                                    ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Recent(
                                    idCabang: cabang[index]['id'].toString()),
                              ),
                            );
                          },
                        ),
                        Divider(
                          thickness: 2,
                          color: Color.fromRGBO(243, 156, 18, 10),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 2.1,
                child: Text("")),
          ],
        ),
      ),
    );
  }

  Future<Null> refreshlist() async {
    refreshkey.currentState?.show(
        atTop:
            true); // change atTop to false to show progress indicator at bottom

    await Future.delayed(Duration(seconds: 2)); //wait herxe for 2 second
    ambildata();
  }
}
