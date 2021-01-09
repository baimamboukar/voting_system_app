import 'package:Electchain/widgets/action_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    Navigator.pushNamed(context, 'create_vote');
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
