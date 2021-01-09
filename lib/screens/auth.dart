import 'package:Electchain/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          backgroundColor: Colors.indigo[100],
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text('AUTHENTICATION',
                      style: GoogleFonts.yanoneKaffeesatz(
                          fontSize: 30.0,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputField(
                        hintText: 'Enter your name',
                        prefixIcon: Icons.account_circle,
                        type: TextInputType.text,
                      ),
                      InputField(
                        hintText: 'Enter your phone number',
                        prefixIcon: Icons.phone,
                        type: TextInputType.phone,
                      ),
                      InputField(
                        hintText: 'Enter your email',
                        prefixIcon: Icons.email,
                        type: TextInputType.emailAddress,
                      ),
                      Text('Choose one Authentication method'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlineButton.icon(
                              color: Colors.indigo,
                              onPressed: () {},
                              icon: Icon(Icons.face_retouching_natural),
                              label: Text('Auth')),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: OutlineButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.lock),
                                label: Text('Auth')),
                          ),
                          OutlineButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.fingerprint),
                              label: Text('Auth')),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {}
                          },
                          child: Text('Submit'))
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
