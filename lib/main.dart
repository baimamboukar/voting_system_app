import 'package:Electchain/config/styles.dart';
import 'package:flutter/material.dart';
import 'screens/screens.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ElectChain',
      theme: ThemeData(
        textTheme: TextTheme(
            button: GoogleFonts.yanoneKaffeesatz(color: Colors.white)),
        fontFamily: "Yanone",
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ElectChain(),
    );
  }
}

class ElectChain extends StatefulWidget {
  @override
  _ElectChainState createState() => _ElectChainState();
}

class _ElectChainState extends State<ElectChain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.dashboard),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.indigo, Colors.blue])),
        ),
        elevation: 0.0,
        title: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.blue,
          child: Text('Electchain',
              style: GoogleFonts.loversQuarrel(
                  fontSize: 52.0, fontWeight: FontWeight.bold)),
        ),
        actions: [
          // ignore: missing_required_param

          IconButton(
              color: Colors.white,
              icon: Icon(Icons.how_to_vote_rounded),
              onPressed: () => print('New vote is being added')),
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: IconButton(
                color: Colors.white,
                icon: Icon(Icons.info_outline_rounded),
                onPressed: () => print('New vote is being added')),
          ),
        ],
      ),
      body: HomeScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Floating Action button pressed'),
        child: Container(
          decoration: BoxStyles.gradientBox,
          child: IconButton(
              icon: Icon(Icons.how_to_vote_rounded),
              onPressed: () => print('How to vote')),
        ),
      ),
    );
  }
}
