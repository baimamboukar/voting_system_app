import 'package:Electchain/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:Electchain/screens/screens.dart';
import 'package:Electchain/controllers/controllers.dart';

class AuthScreen extends GetWidget<AuthController> {
  final _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _phonenumberController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Text('AUTHENTICATION | SIGN UP',
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
                      controller: _nameController,
                      hintText: 'Enter your name',
                      prefixIcon: Icons.account_circle,
                      type: TextInputType.text,
                      obscure: false,
                    ),
                    InputField(
                      controller: _phonenumberController,
                      hintText: 'Enter your phone number',
                      prefixIcon: Icons.phone,
                      type: TextInputType.phone,
                      obscure: false,
                    ),
                    InputField(
                      controller: _emailController,
                      hintText: 'Enter your email',
                      prefixIcon: Icons.email,
                      type: TextInputType.emailAddress,
                      obscure: false,
                    ),

                    InputField(
                      controller: _passwordController,
                      hintText: 'Enter your password',
                      prefixIcon: Icons.lock,
                      type: TextInputType.text,
                      obscure: true,
                    ),

                    // Text('Choose one Authentication method'),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     OutlineButton.icon(
                    //         color: Colors.indigo,
                    //         onPressed: () {},
                    //         icon: Icon(Icons.face_retouching_natural),
                    //         label: Text('Auth')),
                    //     Padding(
                    //       padding:
                    //           const EdgeInsets.only(left: 8.0, right: 8.0),
                    //       child: OutlineButton.icon(
                    //           onPressed: () {},
                    //           icon: Icon(Icons.lock),
                    //           label: Text('Auth')),
                    //     ),
                    //     OutlineButton.icon(
                    //         onPressed: () {},
                    //         icon: Icon(Icons.fingerprint),
                    //         label: Text('Auth')),
                    //   ],
                    // ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            print('creating user....');
                            controller.createUser(
                                _nameController.text,
                                _phonenumberController.text,
                                _emailController.text,
                                _passwordController.text);

                            Get.snackbar('SUCEESS', 'user created',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green);
                          },
                          label: Text('SIGN UP'),
                          icon: Icon(Icons.verified_user),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    FlatButton(
                      onPressed: () => Get.to(Login()),
                      child: Text(
                        'Already have account ? Sign In there',
                        style: TextStyle(color: Colors.red, fontSize: 18.0),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
