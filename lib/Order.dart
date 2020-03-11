import 'package:flutter/material.dart';
import 'package:KimochiAdmin/Beranda.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Order extends StatefulWidget {
  List order = [];
  String cab;
  Order({this.order,this.cab});
  @override
  _OrderState createState() => _OrderState(order: order,cab :cab);
}

class _OrderState extends State<Order> {
  List order = [];
  List trx = [];
  int isSend = 0;
  String cab;
  String dec;
  final namaCont = TextEditingController();
  final hpCont = TextEditingController();
  _OrderState({this.order,this.cab});

  @override
  void initState() {
    this.ambildata();
  }

  Future ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("http://192.168.0.117/nomAdmin/Api/getMaxTrx"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      trx = json.decode(hasil.body);
    });
  }

  double total() {
    double x = 0;
    for (int i = 0; i < order.length; i++) {
      x = x + (double.parse(order[i]['tmp']) * double.parse(order[i]['harga']));
    }
    return x;
  }
  Future setCurrentAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('user', [
      hpCont.text.toString()     
    ]);  
  }
  void decode() {
    String na = "iman";
    String tt = "";
    String pembuka = "Terimakasih+Kak+" +
        namaCont.text +
        "+Sudah+Pesan+Minuman+di+KimochiAdmin.%0D%0A%0D%0ABerikut+pesenan+kakak+%3A%0D%0A%0A";
    String penutup =
        "%0ASelamat+kakak+dapat+voucher+exclusive+belanja+10x+%2810poin%29+dengan+varian+apapun+di+KimochiAdmin+gratis+1+produk+minuman+bebas+pilih.+Dan+pesanan+ini+mendapatkan+1+poin+%F0%9F%91%8D%0D%0A%0D%0ASimpan+struk+digital+ini+ya+Kak%2C+dan+Simpan+No+Kami+ini+juga+dengan+nama+KimochiAdmin-Sejenis+Minuman+untuk+mendapatkan+promo-promo+menarik+lainnya+serta+undian+kejutan+setiap+akhir+bulannya..%0D%0A%0D%0AArigatou+Gozaimasu+%F0%9F%98%8A%F0%9F%99%8F%F0%9F%8F%BB";
    for (int i = 0; i < order.length; i++) {
      // insert(
      //     hpCont.text,
      //     namaCont.text,
      //     order[i]['id'],
      //     order[i]['tmp'],
      //     (double.parse(order[i]['tmp']) * double.parse(order[i]['harga']))
      //         .toString());
      tt = tt +
          order[i]['tmp'] +
          "+" +
          order[i]['nama'].toString() +
          "+=+" +
          (double.parse(order[i]['tmp']) * double.parse(order[i]['harga']))
              .toString() +
          "%0A";
    }
    tt = tt + "%0AJadi+Totalnya+:+" + total().toString() + "%0A";
    setState(() {
      dec = pembuka + tt + penutup;
      isSend = 1;
    });
  }

  addToApi() {
    for (int i = 0; i < order.length; i++) {
      insert(
          hpCont.text,
          namaCont.text,
          order[i]['id'],
          order[i]['tmp'],
          (double.parse(order[i]['tmp']) * double.parse(order[i]['harga']))
              .toString(),          
          );
    }
    setCurrentAccount();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Beranda()),
        (Route<dynamic> route) => false);
  }

  insert(String hp, String n, String m, String j, String st) async {
    int tmp = int.parse(trx[0]['x']);
    tmp = tmp + 1;
    var url = 'http://192.168.0.117/nomAdmin/Api/insertInvoice';
    var response = await http.post(url, body: {
      "nama": n,
      "hp": hp,
      "mkn": m,
      "jmlh": j,
      "trx": tmp.toString(),
      "st": st,
      "cab":cab
    });
    // .then((result) {

    // }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "I n v o i c e s",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'ZCOOL QingKe HuangYou',
            color: Color.fromRGBO(243, 156, 18, 20),
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          // Center(
          //   child: new Image.asset(
          //     'assets/fff.jpg',
          //     width: size.width,
          //     height: size.height,
          //     fit: BoxFit.fill,
          //   ),
          // ),
          Container(
            // margin: EdgeInsets.only(top: 8),
            decoration:
                new BoxDecoration(color: Color.fromRGBO(236, 240, 241, 10)),
            child: Container(
              margin: EdgeInsets.only(top: 9),
              child: Column(
                children: <Widget>[
                  Text(cab),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      primary: false,
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: order == null ? 0 : order.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Map menu = dataMenu[index];
                        return Column(
                          children: <Widget>[
                            FlatButton(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 5, right: 10),
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                      child: CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                              order[index]['gambar']
                                                  .toString()))
                                      // ClipOval(
                                      //   child: Image.network(
                                      //     order[index]['gambar'].toString(),
                                      //   ),
                                      // ),
                                      ),
                                  Text(
                                    order[index]['tmp'].toString() + "   ",
                                    style: TextStyle(
                                      fontFamily: 'ZCOOL QingKe HuangYou',
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Expanded(
                                    child: Text(
                                      order[index]['nama'].toString(),
                                      style: TextStyle(
                                        fontFamily: 'ZCOOL QingKe HuangYou',
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                // addMakanan(index);
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "SubTotal : ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'ZCOOL QingKe HuangYou',
                                  ),
                                ),
                                Text(
                                  (int.parse(order[index]['tmp']) *
                                              int.parse(order[index]['harga']))
                                          .toString() +
                                      " ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'ZCOOL QingKe HuangYou',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Divider(
                              color: Color.fromRGBO(243, 156, 18, 10),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Text(
                    "Total : " + total().toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'ZCOOL QingKe HuangYou',
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(color: Colors.black),
                    child: Container(
                      padding: EdgeInsets.only(left: 8),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            cursorColor: Color.fromRGBO(243, 156, 18, 20),
                            controller: namaCont,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "N a m a   L e n g k a p",
                              labelStyle: TextStyle(
                                fontFamily: 'ZCOOL QingKe HuangYou',
                                color: Color.fromRGBO(243, 156, 18, 20),
                                fontWeight: FontWeight.w400,
                                fontSize: 22,
                              ),
                            ),
                            style: TextStyle(
                                fontFamily: 'ZCOOL QingKe HuangYou',
                                color: Color.fromRGBO(243, 156, 18, 20),
                                fontSize: 20),
                          ),
                          Divider(
                            color: Color.fromRGBO(243, 156, 18, 20),
                          ),
                          TextField(
                            // autofocus: true,
                            cursorColor: Color.fromRGBO(243, 156, 18, 20),
                            controller: hpCont,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "N o m o r  H P",
                              labelStyle: TextStyle(
                                fontFamily: 'ZCOOL QingKe HuangYou',
                                color: Color.fromRGBO(243, 156, 18, 20),
                                fontWeight: FontWeight.w400,
                                fontSize: 22,
                              ),
                            ),
                            style: TextStyle(
                                fontFamily: 'ZCOOL QingKe HuangYou',
                                color: Color.fromRGBO(243, 156, 18, 20),
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.1,
                        child: FlatButton(
                          textColor: Color.fromRGBO(243, 156, 18, 20),
                          color: Colors.black,
                          onPressed: () {
                            if (hpCont.text != "") {
                              decode();
                              launch("https://api.whatsapp.com/send?phone=" +
                                  hpCont.text +
                                  "&text=" +
                                  dec);
                            }
                          },
                          child: Text(
                            hpCont.text == "" ? "---" : "Send",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.1,
                        child: FlatButton(
                          textColor: Color.fromRGBO(243, 156, 18, 20),
                          color: Colors.black,
                          onPressed: () {
                            if (isSend != 0) {
                              addToApi();
                            }
                          },
                          child: Text(
                            isSend == 0 ? "---" : "Add Invoices",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
