import 'package:Electchain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;

class RealtimeResult extends StatefulWidget {
  @override
  _RealtimeResultState createState() => _RealtimeResultState();
}

class _RealtimeResultState extends State<RealtimeResult> {
  ElectionModel election = Get.arguments;

  int totalVoteCount() {
    int totalcount = 0;
    for (var candidate in election.options) {
      totalcount += candidate['count'];
    }
    return totalcount;
  }

  double candidatePercentage(int totalCount, int candidateCount) {
    return (candidateCount / totalCount) * 100;
  }

  //Function that will generate a unique color for each candidate
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

  //Functions that will be in charge to generate charts data
  List<charts.Series<Vote, String>> _voteData() {
    List<Vote> voteData = List<Vote>();
    if (election.options != null) {
      for (var candidate in election.options) {
        if (candidate != null &&
            candidate['name'] != null &&
            candidate['count'] != null) {
          Vote vote =
              Vote(candidate['name'], candidate['count'], _candidateColor());
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

  @override
  Widget build(BuildContext context) {
    //Calling the function to initiate data
    List<charts.Series> seriesList = _voteData();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "REAL TIME RESULT",
              style: GoogleFonts.yanoneKaffeesatz(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SliverToBoxAdapter(
              child: SizedBox(
            height: 20.0,
          )),
          SliverToBoxAdapter(
            child: Container(
              height: 140,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: election.options.map((option) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildCandidateResult(
                          option['avatar'],
                          option['name'],
                          candidatePercentage(
                              totalVoteCount(), option['count'])),
                    );
                  }).toList()),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20.0,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
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
          )
        ],
      ),
    );
  }
}

Widget _buildCandidateResult(String image, String title, double count) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    height: 105.0,
    width: 110.0,
    child: Column(
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 22.0,
              color: Colors.black38,
              fontWeight: FontWeight.bold),
        ),
        CircleAvatar(
          radius: 35.0,
          backgroundImage: NetworkImage(image),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              "${count.toStringAsFixed(2)} %",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
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
