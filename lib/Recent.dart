import 'package:flutter/material.dart';
import 'package:KimochiAdmin/DetailOrder.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'util/const.dart' as b;

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
        Uri.encodeFull(b.Constants.server + "getTrxByCabang/" + idCabang),
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
        decoration: new BoxDecoration(color: Colors.black),
        // margin: EdgeInsets.only(top: 7),
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
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_today,
                                  color: Color.fromRGBO(243, 156, 18, 20),
                                  size: 20,
                                ),
                                Text(
                                  " " +
                                      current[index]['tanggal'].toString() +
                                      "  ",
                                  style: TextStyle(
                                    fontFamily: 'ZCOOL QingKe HuangYou',
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Icon(
                                  Icons.local_atm,
                                  color: Color.fromRGBO(243, 156, 18, 20),
                                  size: 20,
                                ),
                                Text(
                                  " " +
                                      current[index]['total'].toString() +
                                      "  ",
                                  style: TextStyle(
                                    fontFamily: 'ZCOOL QingKe HuangYou',
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Icon(
                                  current[index]['status'].toString() == "0"
                                      ? Icons.close
                                      : current[index]['status'].toString() ==
                                              "1"
                                          ? Icons.check_box
                                          : current[index]['status']
                                                      .toString() ==
                                                  "2"
                                              ? Icons.playlist_add_check
                                              : Icons.motorcycle,
                                  color: Color.fromRGBO(243, 156, 18, 20),
                                  size: 25.0,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Color.fromRGBO(243, 156, 18, 20),
                                  size: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    "(" +
                                        current[index]['user'].toString() +
                                        ")" +
                                        "--" +
                                        current[index]['alamat'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'ZCOOL QingKe HuangYou',
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailOrder(
                                  notrx: current[index]['notrx'].toString()),
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
          ],
        ),
      ),
    );
  }
}
