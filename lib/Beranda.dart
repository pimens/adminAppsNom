import 'package:flutter/material.dart';
import 'package:KimochiAdmin/Cabang.dart';
import 'package:KimochiAdmin/comp/Draw.dart';
import 'comp/Carousel.dart';
import 'comp/ItemSearch.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Beranda extends StatefulWidget {
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  List dataMenu = [];
  List tmp = [];
  String dec;

  Future<String> getMenu() async {
    String url = "http://192.168.43.184/nomAdmin/Api/getMakanan";
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        dataMenu = content;
      });
    }
    return 'success!!';
  }

  _BerandaState() {
    getMenu();
  }
  void addMakanan(int ind) {
    setState(() {
      int x = int.parse(dataMenu[ind]['tmp']);
      x = x + 1;
      dataMenu[ind]['tmp'] = x.toString();
    });
  }

  void minMakanan(int ind) {
    setState(() {
      int x = int.parse(dataMenu[ind]['tmp']);
      x = x - 1;
      dataMenu[ind]['tmp'] = x.toString();
    });
  }

  void reset() {
    setState(() {
      tmp = [];
      getMenu();
    });
  }

  void add(Map x) {
    setState(() {
      tmp.add(x);
    });
  }

  void order() {
    setState(() {
      tmp = [];
    });
    for (int i = 0; i < dataMenu.length; i++) {
      int flag = 0;
      if (int.parse(dataMenu[i]['tmp']) > 0) {
        {
          add(dataMenu[i]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(      
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "N o m i m a s u",
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Bangers-Regular',
              color: Color.fromRGBO(243, 156, 18, 20),
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
        drawer: Draw(),
        body: Stack(
          children: <Widget>[
            // Center(
            //   child: new Image.asset(
            //     'assets/f1.jpg',
            //     width: size.width,
            //     height: size.height,
            //     fit: BoxFit.fill,
            //   ),
            // ),
            Container(
                decoration:
                    new BoxDecoration(color: Color.fromRGBO(236, 240, 241, 10)),
                child: Column(
                  children: <Widget>[
                    Carousel(url: "http://192.168.43.184/nomAdmin/Api/promo"),
                    Divider(),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                        child: ListView(
                          children: <Widget>[
                            ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: dataMenu == null ? 0 : dataMenu.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map mkn = dataMenu[index];
                                return GestureDetector(
                                    onTap: () {},
                                    child: Column(
                                      children: <Widget>[
                                        ItemSearch(
                                          img: mkn["gambar"].toString(),
                                          title: mkn["nama"],
                                          address: mkn["kategori"],
                                          rating: mkn["harga"],
                                          view: index.toString(),
                                        ),
                                        Center(
                                          child: dataMenu[index]['tmp'] == "0"
                                              ? SizedBox(
                                                  width: double.infinity,
                                                  child: FlatButton(
                                                    textColor: Color.fromRGBO(
                                                        243, 156, 18, 20),
                                                    color: Colors.black,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        243,
                                                                        156,
                                                                        18,
                                                                        20),
                                                                width: 0,
                                                                style:
                                                                    BorderStyle
                                                                        .solid),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        11)),
                                                    onPressed: () {
                                                      addMakanan(index);
                                                    },
                                                    child: Text(
                                                      "Tambah",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'ZCOOL QingKe HuangYou',
                                                          fontSize: 20.0),
                                                    ),
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    FlatButton(
                                                      color: Colors.black,
                                                      textColor: Colors.white,
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      243,
                                                                      156,
                                                                      18,
                                                                      20),
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .solid),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      11)),
                                                      onPressed: () {
                                                        minMakanan(index);
                                                      },
                                                      child: Text(
                                                        "-",
                                                        style: TextStyle(
                                                            fontSize: 20.0),
                                                      ),
                                                    ),
                                                    Text(
                                                      mkn["tmp"].toString(),
                                                      style: TextStyle(
                                                          fontSize: 20.0),
                                                    ),
                                                    FlatButton(
                                                      color: Colors.black,
                                                      textColor: Colors.white,
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      243,
                                                                      156,
                                                                      18,
                                                                      20),
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .solid),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      11)),
                                                      onPressed: () {
                                                        addMakanan(index);
                                                      },
                                                      child: Text(
                                                        "+",
                                                        style: TextStyle(
                                                            fontSize: 20.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                        Divider(
                                          color:
                                              Color.fromRGBO(243, 156, 18, 20),
                                        ),
                                      ],
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: FlatButton(
                              color: Colors.black,
                              textColor: Color.fromRGBO(243, 156, 18, 20),
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.all(8.0),
                              splashColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color.fromRGBO(243, 156, 18, 20),
                                      width: 0,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(11)),
                              onPressed: () {
                                reset();
                              },
                              child: Text(
                                "Reset",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'ZCOOL QingKe HuangYou'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: FlatButton(
                              color: Colors.black,
                              textColor: Color.fromRGBO(243, 156, 18, 20),
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.all(8.0),
                              splashColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color.fromRGBO(243, 156, 18, 20),
                                      width: 0,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(11)),
                              onPressed: () {
                                order();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Cabang(),
                                  ),
                                );
                              },
                              child: Text(
                                "Order",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'ZCOOL QingKe HuangYou'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }
}
