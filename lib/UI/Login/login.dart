import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/buttons.dart';
import 'package:yourwellbeing/Extracted%20Widgets/customtextfield.dart';
import 'package:yourwellbeing/Extracted%20Widgets/snackbar.dart';
import 'package:yourwellbeing/UI/BottomNavigation/bottom_navigation.dart';
import 'package:yourwellbeing/UI/Login/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //For Password Icon
  bool isHiddenPassword = true;
  bool isChecked = false;

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  // To save the value written in the text
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //Connectivity result package to check the internet connection.
  ConnectivityResult result = ConnectivityResult.none;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 100.0, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 120,
                      ),
                      const SizedBox(
                        height: 32.00,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Log in to continue',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'NutinoSansReg',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CustomTextFormField(
                        'Email',
                        Icons.email_outlined,
                        emailController,
                        (String? value) {
                          if (value!.isEmpty) {
                            return "Email can't be empty";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return "Please provide a valid email address";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        style: const TextStyle(
                          fontFamily: 'NutinoSansReg',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff777777),
                        ),
                        controller: passwordController,
                        obscureText: isHiddenPassword,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: kBorder,
                            borderRadius: kBorderRadius,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: kBorder,
                            borderRadius: kBorderRadius,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: kErrorBorder,
                            borderRadius: kBorderRadius,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: kBorder,
                            borderRadius: kBorderRadius,
                          ),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            fontFamily: 'NutinoSansReg',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff777777),
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(8, 16, 0, 0),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 20, right: 12),
                            child: Icon(Icons.lock_outlined, size: 20),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 17),
                            child: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(
                                isHiddenPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter a password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              /*     Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ForgetPassword();
                              }));*/
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontFamily: 'NutinoSansReg',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      LoginButton('Log In', () async {
                        result = await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.mobile ||
                            result == ConnectivityResult.wifi) {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavigation(),
                                ),
                                (route) => route.isFirst);
                          } else {
                            return print("Unsuccessful");
                          }
                        } else {
                          showSnackBar(
                            context,
                            "Attention",
                            Colors.blue,
                            Icons.info,
                            "You must be connected to the internet.",
                          );
                        }
                      }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don’t have an account?  ',
                            style: TextStyle(
                              fontFamily: 'NutinoSansReg',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const SignupPage(),
                                  ),
                                  (route) => route.isFirst);
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'NutinoSansReg',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const BottomNavigation(),
                              ),
                              (route) => route.isFirst);
                        },
                        child: const Text(
                          'View as guest',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'NutinoSansReg',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                          ),
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
    );
  }
}
