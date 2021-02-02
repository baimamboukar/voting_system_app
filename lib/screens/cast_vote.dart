import 'package:Electchain/controllers/controllers.dart';
import 'package:Electchain/models/models.dart';
import 'package:Electchain/screens/realtime_result.dart';
import 'package:Electchain/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CastVote extends StatefulWidget {
  @override
  _CastVoteState createState() => _CastVoteState();
}

class _CastVoteState extends State<CastVote> {
  @override
  Widget build(BuildContext context) {
    List options = Get.arguments.options;
    var target;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            "CAST YOUR VOTE",
            style: GoogleFonts.yanoneKaffeesatz(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.info),
                onPressed: () => print("Display something")),
            IconButton(
                icon: Icon(Icons.info),
                onPressed: () => print("Display something")),
          ],
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
          child: Divider(),
        ),
        SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
                child: Center(
              child: Text(
                Get.arguments.name.toString().toUpperCase(),
                style: GoogleFonts.yanoneKaffeesatz(
                    fontSize: 28.0,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold),
              ),
            ))),
        SliverToBoxAdapter(
            child: Center(
          child: Text(
            Get.arguments.description.toString(),
            style: GoogleFonts.yanoneKaffeesatz(
                fontSize: 20.0,
                color: Colors.grey,
                fontWeight: FontWeight.bold),
          ),
        )),
        SliverToBoxAdapter(
          child: SizedBox(height: 40.0),
        ),
        // SliverPadding(
        //   padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        //   sliver: SliverToBoxAdapter(
        //     child: Text(
        //         "You are required to choose only one option and confirm your choice",
        //         style: TextStyle(color: Colors.grey, fontSize: 18.0)),
        //   ),
        // ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                      height: 70.0,
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          gradient: LinearGradient(
                            end: Alignment.bottomRight,
                            colors: [Colors.indigo[200], Colors.blue[200]],
                          )),
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                NetworkImage(options[index]["avatar"])),
                        trailing: Text(
                          "${options[index]["count"].toString()} Votes",
                          style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                            options[index]["name"].toString().toUpperCase()),
                        subtitle: Text(options[index]["description"]),
                        onTap: () {
                          Get.dialog(
                            AlertDialog(
                              title: ListTile(
                                leading: Icon(
                                  Icons.warning,
                                  size: 36.0,
                                  color: Colors.yellow,
                                ),
                                title: Text("CONFIRM YOUR CHOICE PLEASE"),
                                subtitle: Text(
                                    "Notice that you cannot change after confirmation"),
                              ),
                              content: Container(
                                height: 230.0,
                                // width: 250.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.indigo[300],
                                          Colors.blue
                                        ])),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10.0,
                                          ),
                                          child: CircleAvatar(
                                              radius: 60.0,
                                              backgroundImage: NetworkImage(
                                                  options[index]["avatar"])),
                                        ),
                                      ),
                                      SizedBox(height: 15.0),
                                      Text(options[index]["name"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 5.0),
                                      Text(
                                        options[index]["description"],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                        "${options[index]["count"].toString()} VOTES COUNT",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10.0),
                                    ],
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                ElevatedButton.icon(
                                    onPressed: () {
                                      FirebaseFirestore _firestore =
                                          FirebaseFirestore.instance;
                                      List<ElectionModel> allElections =
                                          List<ElectionModel>();
                                      var usersQuerySnap =
                                          _firestore.collection("users").get();
                                      usersQuerySnap.then((usersQuery) {
                                        var _allUsers = usersQuery.docs
                                            .map((_user) =>
                                                Get.find<UserController>()
                                                    .fromDocumentSnapshot(
                                                        _user))
                                            .toList();

                                        _allUsers.forEach((user) {
                                          _firestore
                                              .collection("users")
                                              .doc(user.id)
                                              .collection("elections")
                                              .get()
                                              .then((_userElectionsSnap) {
                                            var userElections = _userElectionsSnap
                                                .docs
                                                .map((_election) => Get.find<
                                                        ElectionController>()
                                                    .fromDocumentSnapshot(
                                                        _election))
                                                .toList();
                                            userElections.forEach((element) {
                                              if (element.accessCode ==
                                                  Get.arguments.accessCode) {
                                                setState(() {
                                                  target = element;
                                                });
                                                _firestore
                                                    .collection("users")
                                                    .doc(element.owner)
                                                    .collection("elections")
                                                    .doc(element.id)
                                                    .update({
                                                  "options":
                                                      FieldValue.arrayRemove([
                                                    {
                                                      "avatar":
                                                          element.options[index]
                                                              ['avatar'],
                                                      "name":
                                                          element.options[index]
                                                              ['name'],
                                                      "description":
                                                          element.options[index]
                                                              ['description'],
                                                      "count":
                                                          element.options[index]
                                                              ['count']
                                                    }
                                                  ])
                                                });

                                                element.options[index]
                                                    ['count']++;
                                                var updatedOption =
                                                    element.options[index];

                                                _firestore
                                                    .collection("users")
                                                    .doc(element.owner)
                                                    .collection("elections")
                                                    .doc(element.id)
                                                    .update({
                                                  "options":
                                                      FieldValue.arrayUnion([
                                                    {
                                                      "avatar": updatedOption[
                                                          'avatar'],
                                                      "name":
                                                          updatedOption['name'],
                                                      "description":
                                                          updatedOption[
                                                              'description'],
                                                      "count":
                                                          updatedOption['count']
                                                    }
                                                  ])
                                                }).then((value) {
                                                  Get.to(RealtimeResult(),
                                                      arguments: target);
                                                });
                                              }
                                            });
                                            // allElections.forEach((election) {
                                            //   print(Get.arguments.name);
                                            //   if (election.accessCode ==
                                            //       Get.arguments.accessCode) {
                                            //   } else {
                                            //     print("NOT FOUND YET");
                                            //   }
                                            // });
                                          });
                                        });
                                        //print("All elections $allElections");
                                      });
                                    },
                                    icon: Icon(Icons.how_to_vote),
                                    label: Text("Confirm"))
                              ],
                            ),
                            barrierDismissible: true,
                            arguments: Get.arguments,
                          );
                        },
                      )));
            },
            childCount: options.length,
          ),
        ),
      ],
    ));
  }
}
