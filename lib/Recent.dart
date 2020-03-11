import 'package:flutter/material.dart';
import 'package:KimochiAdmin/DetailOrder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Recent extends StatefulWidget {
  String idCabang;
  Recent({this.idCabang});
  @override
  _RecentState createState() => _RecentState(idCabang: idCabang);
}

class _RecentState extends State<Recent> {
  List user = [];
  List current = [];
  String idCabang;
  _RecentState({this.idCabang});  

  Future ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("http://192.168.0.117/nomAdmin/Api/getTrxByCabang/" + idCabang),
        headers: {"Accept": "application/json"});
    this.setState(() {
      current = json.decode(hasil.body);
    });
  }

  @override
  void initState() {
    super.initState();
    this.ambildata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Recent Orders - Cabang",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'ZCOOL QingKe HuangYou',
            color: Color.fromRGBO(243, 156, 18, 20),
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 7),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: current == null ? 0 : current.length,
                itemBuilder: (BuildContext context, int index) {
                  // Map menu = dataMenu[index];
                  return Column(
                    children: <Widget>[
                      FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: Color.fromRGBO(243, 156, 18, 20),
                              size: 15.0,
                            ),
                            Text(
                              " " + current[index]['tanggal'].toString() + "  ",
                              style: TextStyle(
                                fontFamily: 'ZCOOL QingKe HuangYou',
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Icon(
                              Icons.location_on,
                              color: Color.fromRGBO(243, 156, 18, 20),
                              size: 15.0,
                            ),
                            Expanded(
                              child: Text(
                                current[index]['nama'].toString(),
                                style: TextStyle(
                                  fontFamily: 'ZCOOL QingKe HuangYou',
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Icon(
                              Icons.local_atm,
                              color: Color.fromRGBO(243, 156, 18, 20),
                              size: 15.0,
                            ),
                            Text(
                              " " + current[index]['total'].toString() + "  ",
                              style: TextStyle(
                                fontFamily: 'ZCOOL QingKe HuangYou',
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Icon(
                              current[index]['status'].toString() == "0"
                                  ? Icons.close
                                  : Icons.check_box,
                              color: Color.fromRGBO(243, 156, 18, 20),
                              size: 25.0,
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailOrder(notrx:  current[index]['notrx'].toString()),
                            ),
                          );
                        },
                      ),
                      Divider(
                        color: Color.fromRGBO(243, 156, 18, 10),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
