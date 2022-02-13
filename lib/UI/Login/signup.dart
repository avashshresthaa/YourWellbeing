import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/buttons.dart';
import 'package:yourwellbeing/Extracted%20Widgets/customtextfield.dart';
import 'package:yourwellbeing/Extracted%20Widgets/snackbar.dart';
import 'package:yourwellbeing/UI/Login/login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isHiddenPassword = true;
  bool isConfirmHiddenPassword = true;
  bool isChecked = false;
  ConnectivityResult result = ConnectivityResult.none;

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      isConfirmHiddenPassword = !isConfirmHiddenPassword;
    });
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                'Sign up to continue',
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
                          'Username',
                          Icons.person,
                          nameController,
                          (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter username";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        CustomTextFormField(
                          'Email',
                          Icons.email_outlined,
                          emailController,
                          (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter email";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return "Please enter valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          style: const TextStyle(
                            fontFamily: 'NutinoSansReg',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff777777),
                          ),
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
                              padding:
                                  const EdgeInsets.only(left: 20, right: 17),
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
                            if (value.length < 8) {
                              return "Your password must be at least 8 character";
                            }
                            if (!value.contains(RegExp(r"[a-z]"))) {
                              return "Your password must have a letter";
                            }
                            if (!value.contains(RegExp(r"[A-Z]"))) {
                              return "Your password should contain at least one uppercase letter";
                            }
                            if (!value.contains(RegExp(r"[0-9]"))) {
                              return "Your password should contain  a numerical value";
                            }
                            if (!value
                                .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                              return "Your password should contain one special character";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          controller: confirmPasswordController,
                          style: const TextStyle(
                            fontFamily: 'NutinoSansReg',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff777777),
                          ),
                          obscureText: isConfirmHiddenPassword,
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
                            hintText: 'Confirm Password',
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
                              padding:
                                  const EdgeInsets.only(left: 20, right: 17),
                              child: InkWell(
                                onTap: _toggleConfirmPasswordView,
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
                              return "Please re enter your password";
                            }
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              return "Both the passwords don't match";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        LoginButton('Sign Up', () async {
                          result = await Connectivity().checkConnectivity();
                          if (result == ConnectivityResult.mobile ||
                              result == ConnectivityResult.wifi) {
                            if (_formKey.currentState!.validate()) {
                              final name = nameController.text;
                              final email = emailController.text;
                              final password = passwordController.text;
                              final confirmPassword =
                                  confirmPasswordController.text;
                            } else {
                              /*   showSnackBar(
                                context,
                                "Attention",
                                Colors.red,
                                Icons.info,
                                "Unsuccessful.",
                              );*/
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
                            Text(
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
                                      builder: (context) => LoginPage(),
                                    ),
                                    (route) => route.isFirst);
                              },
                              child: Text(
                                'Log In',
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
