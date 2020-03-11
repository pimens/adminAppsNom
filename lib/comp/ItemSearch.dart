import 'package:flutter/material.dart';
import 'package:KimochiAdmin/util/const.dart';
import 'package:expandable/expandable.dart';

import '../Beranda.dart' as dd;

class ItemSearch extends StatefulWidget {
  final String img;
  final String title;
  final String address;
  final String rating;
  final String view;

  ItemSearch({
    Key key,
    @required this.img,
    @required this.title,
    @required this.address, //katgori
    @required this.rating, //harga
    @required this.view,
  }) : super(key: key);

  @override
  _ItemSearchState createState() => _ItemSearchState();
}

class _ItemSearchState extends State<ItemSearch> {
  Widget judul(BuildContext context) {
    return ExpandablePanel(
      // header: Text("xxx"),
      collapsed: Text(
        " ${widget.title} ",
        style: TextStyle(fontSize: 25.0, fontFamily: 'ZCOOL QingKe HuangYou'),
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      expanded: Text(
        " ${widget.title} ",
        softWrap: true,
        style: TextStyle(fontSize: 25.0, fontFamily: 'ZCOOL QingKe HuangYou'),
      ),
      tapHeaderToExpand: true,
      hasIcon: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        // color: Color(0xFF3B3A3A),
        height: MediaQuery.of(context).size.height / 2.7,
        width: MediaQuery.of(context).size.width / 1.3,
        child: Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Color.fromRGBO(243, 156, 18, 20),
                  width: 0,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10.0)),
          elevation: 3.0,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.network(
                        "${widget.img}",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6.0,
                    right: 6.0,
                    child: Container(
                      child: Card(
                        color: Color.fromRGBO(243, 156, 18, 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.monetization_on,
                                color: Constants.darkPrimary,
                                size: 10,
                              ),
                              Text(
                                " ${widget.rating} ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),          
                ],
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[                           
                            Expanded(
                              child: new Container(
                                  padding: EdgeInsets.only(left: 7.0),
                                  width: MediaQuery.of(context).size.width,                               
                                  child: judul(context)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
