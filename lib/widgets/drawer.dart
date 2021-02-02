import 'package:Electchain/controllers/auth_controller.dart';
import 'package:Electchain/controllers/controllers.dart';
import 'package:Electchain/models/models.dart';
import 'package:Electchain/screens/screens.dart';
import 'package:Electchain/screens/screens.dart';
import 'package:Electchain/screens/user_elections.dart';
import 'package:Electchain/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ElectionModel election;
void getElection(userId, electionId) async {
  election = await DataBase().getElection(userId, electionId);
}

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
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
            accountEmail: Obx(
              () => Text(Get.find<UserController>().user.email,
                  style: TextStyle(color: Colors.white54)),
            ),
            currentAccountPicture: CircleAvatar(
                radius: 60.0,
                backgroundImage:
                    NetworkImage(Get.find<UserController>().user.avatar)),
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
            title: Text('Home'),
            subtitle: Text('Go to homepage'),
            leading: _leadingIcon(Icons.home),
            onLongPress: () {},
          ),
          ListTile(
            title: Text('Owned Elections'),
            subtitle: Text('My elections'),
            leading: _leadingIcon(Icons.how_to_vote),
            onLongPress: () {},
            onTap: () => Get.to(UserElections()),
          ),
          ListTile(
            title: Text('Settings'),
            subtitle: Text('Modify settings'),
            leading: _leadingIcon(Icons.settings),
            onLongPress: () {},
            onTap: () => Get.to(Settings()),
          ),
          ListTile(
            title: Text('Info'),
            subtitle: Text('About ElectChain'),
            leading: _leadingIcon(Icons.info),
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
            height: 70.0,
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
