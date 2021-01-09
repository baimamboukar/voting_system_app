import 'package:Electchain/config/styles.dart';
import 'package:Electchain/screens/screens.dart';
import 'package:Electchain/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ElectChain extends StatefulWidget {
  @override
  _ElectChainState createState() => _ElectChainState();
}

class _ElectChainState extends State<ElectChain> {
  final GlobalKey _scafflofKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      key: _scafflofKey,
      appBar: AppBar(
        //  leading: IconButton(
        //   icon: Icon(Icons.dashboard),
        //  onPressed: () {
        //     Scaffold.of(context).openDrawer();
        // }),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.indigo, Colors.blue])),
        ),
        elevation: 0.0,
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'ELECT',
                style: GoogleFonts.gugi(
                    color: Colors.pink[300],
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: 'CHAIN',
                style: GoogleFonts.gugi(
                    fontSize: 18.0, fontWeight: FontWeight.bold))
          ]),
        ),
        actions: [
          // ignore: missing_required_param

          IconButton(
              color: Colors.white,
              icon: Icon(Icons.how_to_vote_rounded),
              onPressed: () {}),
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: IconButton(
                color: Colors.white,
                icon: Icon(Icons.info_outline_rounded),
                onPressed: () {
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
                }),
          ),
        ],
      ),
      body: HomeScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(NewVote()),
        child: Container(
          decoration: BoxStyles.gradientBox,
          child: IconButton(
              icon: Icon(Icons.how_to_vote_rounded),
              onPressed: () => print('How to vote')),
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: 30.0),
            Text("Enter a vote code"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    height: 50.0,
                    margin: const EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Form(
                      key: GlobalKey<FormState>(),
                      child: TextFormField(
                        controller: TextEditingController(),
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Vote Code',
                          hintText: "Enter the election code",
                          hintStyle: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.normal),
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.verified_user,
                              )),
                        ),
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 20.0, left: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.indigo, Colors.blue])),
                  child: FlatButton.icon(
                      height: 40.0,
                      color: Colors.indigo,
                      onPressed: null,
                      icon: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Validate",
                      )),
                )
              ],
            ),
            SizedBox(
              height: 80.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(NewVote());
                  },
                  child: ActionBox(
                    action: "Vote",
                    description: "Create a new vote",
                    image: Icons.how_to_vote,
                  ),
                ),
                ActionBox(
                    action: "Poll",
                    description: "Create a new poll",
                    image: Icons.poll),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionBox(
                  action: "Election",
                  description: "Create a new vote",
                  image: Icons.ballot,
                ),
                ActionBox(
                    action: "ElectChain",
                    description: "Create a new poll",
                    image: Icons.info),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
