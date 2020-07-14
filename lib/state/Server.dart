import 'package:flutter/cupertino.dart';

class Server with ChangeNotifier{
  String _server="http://192.168.43.184/nomAdmin/";
  String _user ="Pim";
  String get server => _server;
  String get user => _user;
  set user(String value){
    _user = value;
    notifyListeners();
  } 

}