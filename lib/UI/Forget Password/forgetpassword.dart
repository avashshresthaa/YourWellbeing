import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/buttons.dart';
import 'package:yourwellbeing/Services/authentication.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();
  ConnectivityResult result = ConnectivityResult.none;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Text('Loading...'),
          content: Row(
            children: [
              CircularProgressIndicator(
                color: Colors.blue,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(child: Text('The app is loading.'))
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(
        title: "ForgetPassword",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18),
          child: Container(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /*                   Image.asset(
                            'assets/forgetpassword.png',
                            width: 189,
                          ),*/
                          SizedBox(
                            height: 40.0,
                          ),
                          Text(
                            'Enter the email address associated with your\naccount.',
                            textAlign: TextAlign.center,
                            style: kStyleHomeTitle,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            'We will email you a link to reset your\npassword.',
                            textAlign: TextAlign.center,
                            style: kStyleHomeTitle,
                          ),
                          SizedBox(
                            height: 16.00,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 53.0),
                            child: TextFormField(
                              controller: emailController,
                              style: kStyleHomeTitle,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFA3A3A3), width: 1.5),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFA3A3A3), width: 1.5),
                                ),
                                hintText: 'Enter Email Address',
                                hintStyle: kStyleHomeTitle,
                                /*    contentPadding:
                                          EdgeInsets.fromLTRB(0, 0, 0, 0),*/
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return "Please enter valid email";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 34.0),
                            child: LoginButton(
                              'Send',
                              () {
                                print(emailController.text);
                                AuthMethods auth = AuthMethods();
                                auth.resetPassword(emailController.text);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
