import 'package:flutter/material.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'Recent.dart';

class Cabang extends StatefulWidget {
  @override
  _CabangState createState() => _CabangState();
}

class _CabangState extends State<Cabang> {
  List cabang = [];
  var refreshkey = GlobalKey<RefreshIndicatorState>();
  Future ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("http://192.168.0.117/nomAdmin/Api/getCabangOrder"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      cabang = json.decode(hasil.body);
    });
  }

  Timer timer;

  @override
  void initState() {
    super.initState();
    this.ambildata();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => ambildata());
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
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.only(right: 13),
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.black,
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(10.0)),
                                ),
                                child: Text(
                                  (index + 1).toString() + "     ",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Color.fromRGBO(243, 156, 18, 20),
                                      fontFamily: 'ZCOOL QingKe HuangYou'),
                                  textAlign: TextAlign.center,
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

    await Future.delayed(Duration(seconds: 2)); //wait here for 2 second
    ambildata();
  }
}
