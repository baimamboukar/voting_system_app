import 'package:Electchain/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.indigo, Colors.blue])),
      child: Drawer(
          child: Container(
        color: Colors.indigo[100],
        child: ListView(padding: EdgeInsets.all(0.0), children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'Baimam Boukar',
              style: TextStyle(fontSize: 22.0),
            ),
            accountEmail:
                Text('ID 81132002', style: TextStyle(color: Colors.grey)),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/icons/user.jpeg'),
            ),
            otherAccountsPictures: <Widget>[
              CircleAvatar(
                child: Text('B'),
                backgroundColor: Colors.indigo,
              ),
              CircleAvatar(
                child: Text('JJ'),
              ),
            ],
            onDetailsPressed: () {},
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.indigo, Colors.blue])),
          ),
          ListTile(
            title: Text('Profile'),
            subtitle: Text('User profile'),
            leading: _leadingIcon(Icons.account_circle_sharp),
            onLongPress: () {},
          ),
          ListTile(
            title: Text('Dashboard'),
            subtitle: Text('Vote dashboard'),
            leading: _leadingIcon(Icons.dashboard),
            onTap: () {
              Get.to(VoteDashboard());
            },
          ),
          ListTile(
            title: Text('Settings'),
            subtitle: Text('Modify settings'),
            leading: _leadingIcon(Icons.settings),
            onLongPress: () {},
          ),
          ListTile(
            title: Text('Info'),
            subtitle: Text('About ElectChain'),
            leading: _leadingIcon(Icons.info),
            trailing: Icon(Icons.keyboard_arrow_right),
            onLongPress: () {},
          ),
          ListTile(
              title: Text('Log Out'),
              subtitle: Text('Log out'),
              leading: _leadingIcon(Icons.logout),
              trailing: Icon(Icons.arrow_forward_ios),
              onLongPress: () {},
              onTap: () => Navigator.pushNamed(context, 'auth')),
          Spacer(),
          Image(
            // color: Color,
            image: AssetImage('assets/icons/logo.png'),
            filterQuality: FilterQuality.high,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Developped by Baimam Boukar',
              style: TextStyle(color: Colors.grey, fontSize: 18.0),
            ),
          )
        ]),
      )),
    );
  }
}

Widget _leadingIcon(IconData icon) {
  return CircleAvatar(
    backgroundColor: Colors.indigo,
    child: Icon(
      icon,
      color: Colors.white,
    ),
  );
}
