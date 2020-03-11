import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class Carousel extends StatefulWidget {
  final String url;
  Carousel({this.url});
  @override
  _CarouselState createState() => _CarouselState(url: url);
}

class _CarouselState extends State<Carousel> {
  String url;
  static const Cubic fastOutSlowIn = Cubic(0.4, 0.0, 0.2, 1.0);
  _CarouselState({this.url});
  static double h = 80;
  List data = [];
  Future<String> getData() async {
    var res = await http
        .get(Uri.encodeFull(this.url), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        data = content;
      });
    }
    return 'success!';
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 20),
            child: CarouselSlider(
                height: 140,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: fastOutSlowIn,
                pauseAutoPlayOnTouch: Duration(seconds: 10),
                enlargeCenterPage: true,
                // onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
                items: data.length == 0
                    ? [1].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            h = 200;
                            // return new CircularProgressIndicator();
                            return SpinKitRotatingCircle(
                              color: Colors.white,
                              size: 50.0,
                            );
                          },
                        );
                      }).toList()
                    : data.map((d) {
                        return Builder(
                          builder: (BuildContext context) {
                            h = 200;
                            return GestureDetector(
                                onTap: () {},
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.5,
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Image.network(
                                          d['gambar'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5.0,
                                      left: 5.0,
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        margin: EdgeInsets.only(top:10,left:10),
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.rectangle,
                                            color: Colors.black,
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(5.0)),
                                        ),
                                        child: Text(
                                         d['deskripsi'].toString(),
                                          softWrap: true,
                                          style: TextStyle(
                                            fontSize: 20,
                                             color: Color.fromRGBO(243, 156, 18, 20),
                                            fontFamily: 'ZCOOL QingKe HuangYou'
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 25.0,
                                      right: 3.0,
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.red,
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(32.0)),
                                        ),
                                        child: Card(
                                          elevation: 0,
                                          color: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                          child: Padding(
                                            padding: EdgeInsets.all(1.0),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.monetization_on,
                                                  color: Colors.white,
                                                  size: 10,
                                                ),
                                                Text(
                                                  d['id'].toString(),
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 1.0,
                                      right: 3.0,
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.red,
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(32.0)),
                                        ),
                                        child: Card(
                                          elevation: 0,
                                          color: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0)),
                                          child: Padding(
                                            padding: EdgeInsets.all(1.0),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.white,
                                                  size: 10,
                                                ),
                                                Text(
                                                  d['id'].toString(),
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 6.0,
                                      right: 6.0,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.0)),
                                        child: Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                d['id'],
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          },
                        );
                      }).toList())),
      ],
    );
  }
}
