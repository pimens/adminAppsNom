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
  Future ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("http://192.168.0.117/nomAdmin/Api/getCabangOrder"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      cabang = json.decode(hasil.body);
    });
  }

  @override
  void initState() {
    this.ambildata();
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
        margin: EdgeInsets.only(top: 7),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: cabang == null ? 0 : cabang.length,
                itemBuilder: (BuildContext context, int index) {
                  // Map menu = dataMenu[index];
                  return Column(
                    children: <Widget>[
                      FlatButton(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              (index + 1).toString() + "     ",
                              style: TextStyle(
                                fontFamily: 'ZCOOL QingKe HuangYou',
                                color: Colors.black,
                                fontSize: 40,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Expanded(
                              child: Text(
                                cabang[index]['nama'].toString(),
                                style: TextStyle(
                                  fontFamily: 'ZCOOL QingKe HuangYou',
                                  color: Colors.black,
                                  fontSize: 21,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(6),
                              margin: EdgeInsets.only(top: 10, left: 10),
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.black,
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(20.0)),
                              ),
                              child: Text(
                                cabang[index]['jumlah'].toString(),
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(243, 156, 18, 20),
                                    fontFamily: 'ZCOOL QingKe HuangYou'),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Recent(idCabang: cabang[index]['id'].toString()),
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
