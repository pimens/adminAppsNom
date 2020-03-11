import 'package:flutter/material.dart';
import 'package:KimochiAdmin/Beranda.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'Cabang.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KimochiAdmin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: Sp(),
    );
  }
}

class Sp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new Cabang(),
      title: Text(
        "N o m i m a s u",
        style: TextStyle(
          fontSize: 30,
          fontFamily: 'Bangers-Regular',
          color: Color.fromRGBO(243, 156, 18, 20),
          // fontWeight: FontWeight.bold,
        ),
      ),
      // image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
      image: Image.asset("assets/logo.jpg"),
      backgroundColor: Color.fromRGBO(226, 225, 223, 20),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("KimochiAdmin"),
      loaderColor: Color.fromRGBO(243, 156, 18, 20),
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
  int _counter = 0;
  List dataMenu = [];
  List tmp = [];
  String dec;

  Future<String> getMenu() async {
    // String url =
    //     "http://infinacreativa.com/neonton/index.php?Apii/getEcourseByKategori/course";
    String url = "http://192.168.0.117/nomAdmin/Api/getMakanan";
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        dataMenu = content;
      });
    }
    return 'success!';
  }

  _MyHomePageState() {
    getMenu();
    // decode();
  }
  void add(Map x) {
    setState(() {
      tmp.add(x);
    });
  }

  void decode() {
    String na = "iman";
    String tt = "";
    String pembuka = "Terimakasih+Kak+" +
        na +
        "+Sudah+Pesan+Minuman+di+KimochiAdmin.%0D%0A%0D%0ABerikut+pesenan+kakak+%3A%0D%0A%0A%0A";
    String penutup =
        "Selamat+kakak+dapat+voucher+exclusive+belanja+10x+%2810poin%29+dengan+varian+apapun+di+KimochiAdmin+gratis+1+produk+minuman+bebas+pilih.+Dan+pesanan+ini+mendapatkan+1+poin+%F0%9F%91%8D%0D%0A%0D%0ASimpan+struk+digital+ini+ya+Kak%2C+dan+Simpan+No+Kami+ini+juga+dengan+nama+KimochiAdmin-Sejenis+Minuman+untuk+mendapatkan+promo-promo+menarik+lainnya+serta+undian+kejutan+setiap+akhir+bulannya..%0D%0A%0D%0AArigatou+Gozaimasu+%F0%9F%98%8A%F0%9F%99%8F%F0%9F%8F%BB";
    for (int i = 0; i < tmp.length; i++) {
      tt = tt +
          tmp[i]['nama'].toString() +
          "+=+" +
          tmp[i]['harga'].toString() +
          "%0A";
    }
    setState(() {
      dec = pembuka + tt + penutup;
    });
  }

  void addMakanan(int ind) {
    setState(() {
      int x = int.parse(dataMenu[ind]['tmp']);
      x = x + 1;
      dataMenu[ind]['tmp'] = x.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(220, 221, 225, 100),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: dataMenu == null ? 0 : dataMenu.length,
                itemBuilder: (BuildContext context, int index) {
                  // Map menu = dataMenu[index];
                  return Row(
                    children: <Widget>[
                      FlatButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              dataMenu[index]['tmp'].toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        onPressed: () {
                          addMakanan(index);
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          add(dataMenu[index]);
                          // decode();
                        },
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              (index + 1).toString() +
                                  ". " +
                                  dataMenu[index]['harga'].toString(),
                              style: TextStyle(
                                color: Colors.blue,
                                decorationStyle: TextDecorationStyle.wavy,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "ddd",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              onPressed: () {
                // decode();
              },
            ),
            FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Masuk",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              onPressed: () {
                launch(
                    "https://api.whatsapp.com/send?phone=6281803738083&text=" +
                        dec);
              },
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: tmp == null ? 0 : tmp.length,
                itemBuilder: (BuildContext context, int index) {
                  // Map menu = dataMenu[index];
                  return GestureDetector(
                    onTap: () {
                      add(tmp[index]);
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          (index + 1).toString() +
                              ". " +
                              tmp[index]['nama'].toString(),
                          style: TextStyle(
                            color: Colors.blue,
                            decorationStyle: TextDecorationStyle.wavy,
                          ),
                        ),
                      ),
                    ),
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
