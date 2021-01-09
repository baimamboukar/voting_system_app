import 'package:Electchain/controllers/auth_controller.dart';
import 'package:Electchain/controllers/controllers.dart';
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
            accountName: Obx(
              () => Text(Get.find<UserController>().user.name),
            ),
            accountEmail: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(Get.find<UserController>().user.email,
                      style: TextStyle(color: Colors.white54)),
                ),
                Obx(
                  () => Text(Get.find<UserController>().user.phoneNumber,
                      style: TextStyle(color: Colors.white54)),
                ),
              ],
            ),
            currentAccountPicture: CircleAvatar(
              radius: 60.0,
              backgroundImage: AssetImage('assets/icons/user.jpeg'),
            ),
            otherAccountsPictures: <Widget>[
              Icon(
                Icons.notification_important,
                color: Colors.white,
              )
            ],
            // onDetailsPressed: () {},
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
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationVersion: '^1.0.0',
                  applicationIcon: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/icons/icon.png'),
                  ),
                  applicationName: 'ElectChain',
                  applicationLegalese: 'Brave Tech Solutions');
            },
          ),
          ListTile(
            title: Text('Log Out'),
            subtitle: Text('Log out'),
            leading: _leadingIcon(Icons.logout),
            trailing: Icon(Icons.arrow_forward_ios),
            // onLongPress: () {
            //   Get.find<AuthController>().signOut();
            //   Get.snackbar(
            //       'SIGN OUT', 'You have been successfully signed out');
            // },
            onTap: () {
              Get.find<AuthController>().signOut();
            },
          ),
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
