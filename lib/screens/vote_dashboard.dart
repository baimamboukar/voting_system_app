import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:get/get.dart';

class VoteDashboard extends StatefulWidget {
  @override
  _VoteDashboardState createState() => _VoteDashboardState();
}

class _VoteDashboardState extends State<VoteDashboard> {
  static List<charts.Series<Vote, String>> _randomData() {
    final random = Random();
    final voteData = [
      Vote('Flutter', random.nextInt(10000), Colors.black), //Davna
      Vote('Vue', random.nextInt(10000), Colors.deepPurple), //Bana
      Vote('Ember', random.nextInt(10000), Colors.indigo), //Grace
      Vote('Svelte', random.nextInt(10000), Colors.blue), //Bisama
      Vote('Polymer', random.nextInt(10000), Colors.deepOrange), //Abenti
      Vote('React', random.nextInt(10000), Colors.brown), //Next
      Vote('Angular', random.nextInt(10000), Colors.cyan), //Grace
      Vote('Node', random.nextInt(10000), Colors.green),
    ];
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

  List<charts.Series> seriesList = _randomData();

  var _currentIndex;
  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  void updateIndex(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Icon(Icons.dashboard),
            title: Column(
              children: [
                Text(
                  'BEST WEB APP FRAMEWORK',
                  style:
                      GoogleFonts.yanoneKaffeesatz(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Lorem ipsum dolor si amet do set consectur',
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
                  onPressed: null)
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatsBox(Icons.how_to_vote, 'VOTE', '8113'),
                  _StatsBox(Icons.people_alt, 'CANDIDATES', '4'),
                  _StatsBox(Icons.lock_clock, '12:55', '4H')
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
                        animationDuration: Duration(seconds: 2),
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
                                        color: Colors.indigo, fontSize: 18.0),
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
