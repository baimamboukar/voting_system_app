import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class VoteDashboard extends StatefulWidget {
  @override
  _VoteDashboardState createState() => _VoteDashboardState();
}

class _VoteDashboardState extends State<VoteDashboard> {
  static List<charts.Series<Vote, String>> _randomData() {
    final random = Random();
    final voteData = [
      Vote('Flutter', random.nextInt(1000)), //Davna
      Vote('Vue', random.nextInt(1000)), //Bana
      Vote('React', random.nextInt(1000)), //Bavdam
      Vote('Angular', random.nextInt(1000)), //Khalimat
      Vote('Ember', random.nextInt(1000))
    ];
    return [
      charts.Series<Vote, String>(
          id: 'Best Framework',
          labelAccessorFn: (Vote votes, _) => votes.voter,
          // colorFn: (Vote votes, _) =>
          // charts.ColorUtil.fromDartColor(votes.voterColor),
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
            collapsedHeight: 100.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(image: AssetImage('assets/icons/logo.png')),
              title: Text('BEST MOBILE FRAMEWORK',
                  style: GoogleFonts.yanoneKaffeesatz(
                      fontSize: 25.0, fontWeight: FontWeight.bold)),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatsBox(Icons.how_to_vote, 'VOTE', '8113'),
                  _StatsBox(Icons.people_alt, 'CANDIDATES', '4'),
                  _StatsBox(Icons.ballot, 'VIEWS', '4')
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: MediaQuery.of(context).size.width * 0.50,
                  //  color: Colors.amber,
                  child: charts.BarChart(
                    seriesList,
                    animate: true,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.275,
                      width: MediaQuery.of(context).size.width * 0.50,
                      // color: Colors.green,
                      child: charts.PieChart(
                        seriesList,
                        animate: true,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.275,
                      width: MediaQuery.of(context).size.width * 0.50,
                      // color: Colors.pinkAccent,
                      child: Text('CHART VIEWS'),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.indigo,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.40),
        selectedIconTheme:
            IconThemeData(color: Colors.white, size: 25.0, opacity: 1),
        unselectedIconTheme: IconThemeData(
            color: Colors.white.withOpacity(0.40), size: 22.0, opacity: 0.4),
        selectedFontSize: 18,
        unselectedFontSize: 14,
        onTap: (index) {
          updateIndex(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.how_to_vote, color: Colors.white),
              label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people_alt,
                color: Colors.white,
              ),
              label: 'Voters'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ),
              label: 'Info'),
        ],
      ),
    );
  }
}

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

  Vote(this.voter, this.voteCount);
}
