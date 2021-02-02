import 'package:Electchain/controllers/controllers.dart';
import 'package:Electchain/controllers/user_controller.dart';
import 'package:Electchain/screens/vote_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class UserElections extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return Scaffold(
      body: StreamBuilder(
        stream: _firestore
            .collection("users")
            .doc(Get.find<UserController>().user.id)
            .snapshots(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var elections = snapshot.data.data()['owned_elections'];
            if (elections.length < 1) {
              return Center(
                child: ListTile(
                  leading: Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.red,
                  ),
                  title: Text("Sorry you dont have any election"),
                  subtitle: Text("Your elections will be displayed there"),
                ),
              );
            }
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    "OWNED ELECTIONS",
                    style: GoogleFonts.yanoneKaffeesatz(
                        fontSize: 28.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Image(
                        image: AssetImage('assets/icons/logo.png'),
                        height: 80.0,
                        width: 300.0,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: const SizedBox(
                    height: 30.0,
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return StreamBuilder(
                    stream: _firestore
                        .collection("users")
                        .doc(Get.find<UserController>().user.id)
                        .collection("elections")
                        .doc(elections[index])
                        .snapshots(),
                    // ignore: missing_return
                    builder: (context, snap) {
                      if (snap.hasData) {
                        return GestureDetector(
                          onTap: () {
                            print("working.......");
                            Get.to(VoteDashboard(),
                                arguments: [snap.data.data()]);
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                  height: 70.0,
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      gradient: LinearGradient(
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.indigo[200],
                                          Colors.blue[200]
                                        ],
                                      )),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage: AssetImage(
                                            "assets/icons/logo.png")),
                                    trailing: Icon(Icons.chevron_right),
                                    title: Text(snap.data.data()['name'] != null
                                        ? snap.data.data()['name']
                                        : "Name"),
                                    subtitle:
                                        Text(snap.data.data()['description']),
                                    onTap: () {
                                      print("working.......");
                                      Get.to(VoteDashboard(), arguments: [
                                        Get.find<ElectionController>()
                                            .fromDocumentSnapshot(snap.data)
                                      ]);
                                    },
                                  ))),
                        );
                      } else {
                        return Center(child: Text("Loading..."));
                      }
                    },
                  );
                }, childCount: elections.length))
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading..."));
          }
        },
      ),
    );
  }
}
