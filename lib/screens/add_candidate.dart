import 'package:Electchain/models/models.dart';
import 'package:Electchain/screens/add_vote_option_screen.dart';
import 'package:Electchain/services/database.dart';
import 'package:Electchain/widgets/candidate_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Electchain/controllers/controllers.dart';

var data;

getData() async {
  await DataBase()
      .candidatesStream(
          Get.find<UserController>().user.id, Get.arguments[0].id.toString())
      .then((election) {
    election.data()['options'].length == 0
        ? data = null
        : data = election.data()['options'];
  });
}

class AddCandidate extends StatefulWidget {
  @override
  _AddCandidateState createState() => _AddCandidateState();
}

class _AddCandidateState extends State<AddCandidate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Center(
                  child: Image(
                    image: AssetImage('assets/icons/logo.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                      'VOTE ${Get.arguments[1].name.toString().toUpperCase()}',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.yanoneKaffeesatz(
                          fontSize: 30.0,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Text(
                'CURRENT CANDIDATES',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(15.0),
          sliver: data == null
              ? SliverToBoxAdapter(
                  child: Column(children: [
                    Icon(
                      Icons.wifi_off,
                      size: 100.0,
                    ),
                    Text('NO CANDIDATE ADDED YET',
                        style: TextStyle(
                          fontSize: 20.0,
                        )),
                    Text(
                      'Add candidates or options to your vote to finalise the process',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ]),
                )
              : SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent:
                        MediaQuery.of(context).size.width * 0.50,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return CandidateBox(
                      candidateName: data[index]['name'],
                      candidateDesc: data[index]['description'],
                      onTap: () {
                        Get.bottomSheet(Container(
                          color: Colors.white,
                          height: 60.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FlatButton.icon(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                  label: Text('Edit')),
                              FlatButton.icon(
                                  onPressed: () {
                                    setState(() {});
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Confirmation'),
                                            content: Text('Are you sure ?'),
                                            actions: [
                                              FlatButton(
                                                child: Text('Yes'),
                                                onPressed: null,
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  label: Text('Delete'))
                            ],
                          ),
                        ));
                      },
                    );
                  }, childCount: data.length)),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.to(AddVoteOptionWidget(), arguments: Get.arguments);
                },
                label: Text('Add Candidate'),
                icon: Icon(Icons.group_add),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.only(
              left: 45.0, right: 75.0, top: 40.0, bottom: 0.0),
          child: Container(
            height: 50.0,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10.0)),
            child: FlatButton.icon(
                onPressed: () {
                  Get.to(AddVoteOptionWidget(), arguments: Get.arguments);
                },
                icon: Icon(Icons.check, color: Colors.white),
                label: Text(
                  'RUN THE ELECTION',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                )),
          ),
        )),
      ]),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Refresh the list of the candidates',
        onPressed: () {
          getData();
          setState(() {});
          getData();
          setState(() {});
          getData();
          setState(() {});
          getData();
          setState(() {});
        },
        child: Icon(
          Icons.refresh_outlined,
          color: Colors.green,
        ),
      ),
    );
  }
}
