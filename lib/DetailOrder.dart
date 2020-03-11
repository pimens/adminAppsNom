import 'package:KimochiAdmin/Cabang.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class DetailOrder extends StatefulWidget {
  String notrx;
  DetailOrder({this.notrx});
  @override
  _DetailOrderState createState() => _DetailOrderState(notrx: notrx);
}

class _DetailOrderState extends State<DetailOrder> {
  String notrx;
  List order = [];
  String dec;
  _DetailOrderState({this.notrx});

  Future ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("http://192.168.0.117/nomAdmin/Api/getTrxById/" + notrx),
        headers: {"Accept": "application/json"});
    this.setState(() {
      order = json.decode(hasil.body);
    });
  }

  Future setFinish() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("http://192.168.0.117/nomAdmin/Api/finish/" + notrx),
        headers: {"Accept": "application/json"});
  }

  void decode() {
    String na = "iman";
    String tt = "";
    String pembuka = "Terimakasih+Kak+" +
        order[0]['user'] +
        "+Sudah+Pesan+Minuman+di+Nomimasu.%0D%0A%0D%0ABerikut+pesenan+kakak+%3A%0D%0A%0A";
    String penutup =
        "%0ASelamat+kakak+dapat+voucher+exclusive+belanja+10x+%2810poin%29+dengan+varian+apapun+di+Nomimasu+gratis+1+produk+minuman+bebas+pilih.+Dan+pesanan+ini+mendapatkan+1+poin+%F0%9F%91%8D%0D%0A%0D%0ASimpan+struk+digital+ini+ya+Kak%2C+dan+Simpan+No+Kami+ini+juga+dengan+nama+Nomimasu-Sejenis+Minuman+untuk+mendapatkan+promo-promo+menarik+lainnya+serta+undian+kejutan+setiap+akhir+bulannya..%0D%0A%0D%0AArigatou+Gozaimasu+%F0%9F%98%8A%F0%9F%99%8F%F0%9F%8F%BB";
    for (int i = 0; i < order.length; i++) {
      tt = tt +
          order[i]['jumlah'] +
          "+" +
          order[i]['nama'].toString() +
          "+=+" +
          order[i]['subtotal'].toString() +
          "%0A";
    }
    tt = tt + "%0AJadi+Totalnya+:+" + total().toString() + "%0A";
    setState(() {
      dec = pembuka + tt + penutup;
    });
  }

  @override
  void initState() {
    super.initState();
    this.ambildata();
    total();
  }

  double total() {
    double x = 0;
    for (int i = 0; i < order.length; i++) {
      x = x + (double.parse(order[i]['subtotal']));
    }
    return x;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "DetailOrders",
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
          Container(
            decoration:
                new BoxDecoration(color: Color.fromRGBO(236, 240, 241, 10)),
            child: Container(
              margin: EdgeInsets.only(top: 9),
              child: Column(
                children: <Widget>[
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
                                                  .toString()))),
                                  Text(
                                    order[index]['jumlah'].toString() + "   ",
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
                                  order[index]['subtotal'].toString() + " ",
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
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Total : " + total().toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontFamily: 'ZCOOL QingKe HuangYou',
                      ),
                    ),
                  ),
                  order.length == 0
                      ? Text("")
                      : order[0]['status'] == "0"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.1,
                                  child: FlatButton(
                                    textColor: Color.fromRGBO(243, 156, 18, 20),
                                    color: Colors.black,
                                    onPressed: () {
                                      decode();
                                      setFinish();
                                      launch(
                                          "https://api.whatsapp.com/send?phone=" +
                                              order[0]['nomorhp'] +
                                              "&text=" +
                                              dec);
                                    },
                                    child: Text(
                                      "Kirim Struk",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.1,
                                  child: FlatButton(
                                    textColor: Color.fromRGBO(243, 156, 18, 20),
                                    color: Colors.black,
                                    onPressed: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => Cabang()),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Text(
                                      "Selesai",
                                      // isSend == 0 ? "---" : "Add Invoices",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Text(""),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
