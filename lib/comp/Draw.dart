import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Draw extends StatelessWidget {
  static List data_login = [];
  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data_login = prefs.getStringList('user') ?? [];
    // data_login = prefs.getString('login') ?? '';
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
  }

  Draw() {
    getValuesSF();
  }
  Widget DrawNom(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: GestureDetector(
              child: SizedBox(
                width: 128,
                height: 128,
                child: Image.asset("assets/logo.jpg"),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Color.fromRGBO(243, 156, 18, 20),
                Colors.black,
              ]),
            ),
          ),
          Divider(),
          // InkWell(
          //   onTap: () => Navigator.of(context).push(new MaterialPageRoute(
          //     builder: (BuildContext context) => new Recent(hp:data_login.length==0? (-1).toString() : data_login[0].toString()),
          //   )),
          //   child: ListTile(
          //     title: Text(
          //       "Recent Orders",
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         color: Color.fromRGBO(243, 156, 18, 20),
          //       ),
          //     ),
          //     leading: Icon(
          //       Icons.home,
          //       color: Color.fromRGBO(243, 156, 18, 20),
          //     ),
          //   ),
          // ),
          InkWell(
            onTap: () => logout(),
            child: ListTile(
              title: Text(
                "Logout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(243, 156, 18, 20),
                ),
              ),
              leading: Icon(
                Icons.home,
                color: Color.fromRGBO(243, 156, 18, 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DrawNom(context);
  }
}
