import 'dart:math';
import 'package:Electchain/controllers/election_controller.dart';
import 'package:Electchain/controllers/user_controller.dart';
import 'package:Electchain/models/models.dart';
import 'package:Electchain/screens/home_screen.dart';
import 'package:Electchain/services/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class VoteDashboard extends StatefulWidget {
  @override
  _VoteDashboardState createState() => _VoteDashboardState();
}

class _VoteDashboardState extends State<VoteDashboard> {
  @override
  Widget build(BuildContext context) {
    Color _candidateColor() {
      Random _random = Random();
      List<Color> _colors = [
        Colors.black,
        Colors.amberAccent,
        Colors.indigo,
        Colors.brown,
        Colors.deepOrangeAccent,
        Colors.lightGreenAccent,
        Colors.tealAccent,
        Colors.pinkAccent,
        Colors.yellowAccent,
        Colors.red,
        Colors.purple,
        Colors.lightBlue,
      ];
      int index = _random.nextInt(11);
      return _colors[index];
    }

    // getElection();
    // List<charts.Series<Vote, String>> _randomData() {
    //   getElection();
    //   List<Vote> voteData = List<Vote>();
    //   if (candidates != null) {
    //     for (var candidate in candidates) {
    //       if (candidate != null &&
    //           candidate['name'] != null &&
    //           candidate['count'] != null) {
    //         Vote vote =
    //             Vote(candidate['name'], candidate['count'], _candidateColor());
    //         voteData.add(vote);
    //       }
    //     }
    //   }
    //   return [
    //     charts.Series<Vote, String>(
    //         id: 'Best Framework',
    //         labelAccessorFn: (Vote votes, _) => votes.voter,
    //         colorFn: (Vote votes, _) =>
    //             charts.ColorUtil.fromDartColor(votes.voterColor),
    //         domainFn: (Vote votes, _) => votes.voter,
    //         measureFn: (Vote votes, _) => votes.voteCount,
    //         data: voteData)
    //   ];
    // }
    return Scaffold(
      body: StreamBuilder(
        stream: _firestore
            .collection("users")
            .doc(Get.find<UserController>().user.id)
            .collection("elections")
            .doc(Get.arguments[0].id.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var election = snapshot.data.data();
            var candidates = election['options'];

            //Functions that will be in charge to generate charts data
            List<charts.Series<Vote, String>> _voteData() {
              List<Vote> voteData = List<Vote>();
              if (candidates != null) {
                for (var candidate in candidates) {
                  if (candidate != null &&
                      candidate['name'] != null &&
                      candidate['count'] != null) {
                    Vote vote = Vote(candidate['name'], candidate['count'],
                        _candidateColor());
                    voteData.add(vote);
                  }
                }
              }
              return [
                charts.Series<Vote, String>(
                    id: 'Best Framework',
                    labelAccessorFn: (Vote votes, _) => votes.voter,
                    colorFn: (Vote votes, _) =>
                        charts.ColorUtil.fromDartColor(votes.voterColor),
                    domainFn: (Vote votes, _) => votes.voter,
                    measureFn: (Vote votes, _) => votes.voteCount,
                    data: voteData)
              ];
            }

            //End of chart data functions

            //Clling the function to initiate data
            List<charts.Series> seriesList = _voteData();

            //function to get the total votes count
            int totalVoteCount() {
              int totalcount = 0;
              for (var candidate in candidates) {
                totalcount += candidate['count'];
              }
              return totalcount;
            }

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                      icon: Icon(Icons.dashboard),
                      onPressed: () => Get.to(ElectChain())),
                  title: Column(
                    children: [
                      Text(
                        election['name'] != null
                            ? election['name'].toUpperCase()
                            : "Election Name...",
                        style: GoogleFonts.yanoneKaffeesatz(
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        election["description"],
                        style: GoogleFonts.yanoneKaffeesatz(
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                        tooltip: 'Copy election access code',
                        icon: Icon(
                          Icons.content_copy,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Get.find<ElectionController>()
                              .copyAccessCode(election["accessCode"]);
                        })
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.copy,
                                  color: Colors.white,
                                ),
                                label: Text('Copy Access Code')),
                            ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.refresh,
                                  color: Colors.green,
                                ),
                                label: Text('Regenerate the Code')),
                          ],
                        ),
                        _StatsBox(Icons.people_alt, 'CANDIDATES',
                            election["options"].length.toString()),
                        _StatsBox(Icons.how_to_vote, 'TOTAL VOTES',
                            totalVoteCount().toString())
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.40,
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.black12,
                        child: charts.BarChart(
                          seriesList,
                          animate: true,
                          behaviors: [
                            charts.DatumLegend(
                              outsideJustification:
                                  charts.OutsideJustification.middleDrawArea,
                              horizontalFirst: false,
                              desiredMaxRows: 2,
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.30,
                            width: MediaQuery.of(context).size.width * 0.60,
                            // color: Colors.pinkAccent.withOpacity(.5),
                            child: charts.PieChart(
                              seriesList,
                              animate: true,
                            ),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.30,
                              width: MediaQuery.of(context).size.width * 0.40,
                              //color: Colors.teal.shade200,
                              child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: ListView(
                                    children: [
                                      Center(
                                        child: Text(
                                          'OWNER ACTIONS',
                                          style: TextStyle(
                                              color: Colors.indigo,
                                              fontSize: 18.0),
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.stop,
                                            color: Colors.red,
                                          ),
                                          label: Text('Stop Election')),
                                      ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.copy,
                                          ),
                                          label: Text('Copy Access code')),
                                      ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.bar_chart,
                                            semanticLabel: 'Chart',
                                          ),
                                          label: Text('Get Election\'s stats'))
                                    ],
                                  )))
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return Text("Loaaaaaaaaaading");
          }
        },
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget _StatsBox(IconData icon, String title, String count) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    height: 100.0,
    width: 100.0,
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 22.0,
              color: Colors.black38,
              fontWeight: FontWeight.bold),
        ),
        Icon(
          icon,
          size: 40.0,
          color: Colors.indigo,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            count,
            style: TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        gradient:
            LinearGradient(colors: [Colors.indigo[300], Colors.blue[200]])),
  );
}

class Vote {
  final String voter;
  final int voteCount;
  final Color voterColor;

  Vote(this.voter, this.voteCount, this.voterColor);
}
