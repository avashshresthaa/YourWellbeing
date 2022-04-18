import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/APIModels/getLogin.dart';
import 'package:yourwellbeing/Change%20Notifier/changenotifier.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Constraints/nplanguage.dart';
import 'package:yourwellbeing/Extracted%20Widgets/buttons.dart';
import 'package:yourwellbeing/Extracted%20Widgets/customtextfield.dart';
import 'package:yourwellbeing/Extracted%20Widgets/showdialog.dart';
import 'package:yourwellbeing/Extracted%20Widgets/snackbar.dart';
import 'package:yourwellbeing/Network/NetworkHelper.dart';
import 'package:yourwellbeing/Services/authentication.dart';
import 'package:yourwellbeing/Services/database.dart';
import 'package:yourwellbeing/UI/BottomNavigation/bottom_navigation.dart';
import 'package:yourwellbeing/UI/Forget%20Password/forgetpassword.dart';
import 'package:yourwellbeing/UI/Login/signup.dart';
import 'package:yourwellbeing/Utils/user_prefrences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //For Password Icon
  bool isHiddenPassword = true;
  var language;

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  //For Password Icon
  bool isdocHiddenPassword = true;

  void _toggledocPasswordView() {
    setState(() {
      isdocHiddenPassword = !isdocHiddenPassword;
    });
  }

  // To save the value written in the text
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // To save the value written in the text
  final TextEditingController docemailController = TextEditingController();
  final TextEditingController docpasswordController = TextEditingController();

  //Connectivity result package to check the internet connection.
  ConnectivityResult result = ConnectivityResult.none;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _docformKey = GlobalKey<FormState>();

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  QuerySnapshot? snapshotUserInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    language = UserSimplePreferences.getLanguage() ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 100.0, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
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
                        children: [
                          Text(
                            'Log in to continue',
                            textAlign: TextAlign.start,
                            style: kStyleHomeTitle.copyWith(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                boxShadow: [boxShadow]),
                            child: TabBar(
                                isScrollable: true,
                                unselectedLabelStyle: kStyleHomeTitle,
                                indicator: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(4)),
                                labelColor: Colors.white,
                                labelStyle: kStyleHomeTitle,
                                unselectedLabelColor: kStyleMainGrey,
                                // Tabbar tabs
                                tabs: [
                                  TabBarTabs(
                                    text: 'User',
                                  ),
                                  TabBarTabs(text: 'Doctor')
                                ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: TabBarView(children: [
                              userLoginForm(),
                              docLoginForm(),
                            ]),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  logMeIN() async {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      showWaitDialog(context, language ? 'Please Wait...' : nepWait);
      authMethods
          .signInWithEmailAndPassword(
        email,
        password,
      )
          .then((value) async {
        if (value != null) {
          UserSimplePreferences.saveUserLoggedIn(true);
          UserSimplePreferences.saveUserEmail(email);
          await databaseMethods.getUserByEmail(email).then((val) {
            snapshotUserInfo = val;
            UserSimplePreferences.saveUserName(
                snapshotUserInfo?.docs[0].get("name"));
          });
          Login login = await NetworkHelper().getLoginData(email, password);
          var token = login.token;
          context.read<DataProvider>().token(token);
          UserSimplePreferences.setToken(token!);
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('login', email);
          UserSimplePreferences.setUserLogin('user');
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavigationPage(),
            ),
          );
        } else {
          UserSimplePreferences.saveUserLoggedIn(false);
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pop(context);
          showSnackBar(
            context,
            "Attention",
            Colors.red,
            Icons.info,
            "Invalid Username or Password",
          );
        }
      });
    } else {
      return print("Unsuccessful");
    }
  }

  Widget userLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
              contentPadding: const EdgeInsets.fromLTRB(8, 16, 0, 0),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 20, right: 12),
                child: Icon(Icons.lock_outlined, size: 20),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(left: 20, right: 17),
                child: InkWell(
                  onTap: _togglePasswordView,
                  child: Icon(
                    isHiddenPassword ? Icons.visibility : Icons.visibility_off,
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ForgetPassword();
                  }));
                },
                child: Text(
                  'Forgot Password?',
                  style: kStyleHomeTitle.copyWith(
                    fontSize: 10.sp,
                    color: kStyleGrey333,
                    fontWeight: FontWeight.w400,
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
              logMeIN();
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
                style: kStyleHomeTitle.copyWith(
                  fontSize: 11.sp,
                  color: kStyleGrey333,
                  fontWeight: FontWeight.w400,
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
                child: Text(
                  'Sign Up',
                  style: kStyleHomeTitle.copyWith(
                    fontSize: 11.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          GestureDetector(
            onTap: () async {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationPage(),
                  ),
                  (route) => route.isFirst);
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setString('login', 'guest');
            },
            child: Text(
              'View as guest',
              textAlign: TextAlign.start,
              style: kStyleHomeTitle.copyWith(
                fontSize: 12.sp,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  logMeINDoctor() async {
    if (_docformKey.currentState!.validate()) {
      final email = docemailController.text;
      final password = docpasswordController.text;

      showWaitDialog(context, language ? 'Please Wait...' : nepWait);
      authMethods
          .signInWithEmailAndPassword(
        email,
        password,
      )
          .then((value) async {
        if (value != null) {
          UserSimplePreferences.saveUserLoggedIn(true);
          UserSimplePreferences.saveUserEmail(email);
          await databaseMethods.getUserByEmail(email).then((val) {
            snapshotUserInfo = val;
            UserSimplePreferences.saveUserName(
                snapshotUserInfo?.docs[0].get("name"));
          });
          Login login = await NetworkHelper().getLoginData(email, password);
          var token = login.token;
          context.read<DataProvider>().token(token);
          UserSimplePreferences.setToken(token!);
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('login', email);
          UserSimplePreferences.setUserLogin('doctor');
          Navigator.pop(context);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => BottomNavigationPage(),
              ),
              (route) => route.isFirst);
          /*        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavigationPage(),
            ),
          );*/
        } else {
          UserSimplePreferences.saveUserLoggedIn(false);
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pop(context);
          showSnackBar(
            context,
            "Attention",
            Colors.red,
            Icons.info,
            "Invalid Username or Password",
          );
        }
      });
    } else {
      return print("Unsuccessful");
    }
  }

  Widget docLoginForm() {
    return Form(
      key: _docformKey,
      child: Column(
        children: [
          CustomTextFormField(
            'Email',
            Icons.email_outlined,
            docemailController,
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
            controller: docpasswordController,
            obscureText: isdocHiddenPassword,
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
              contentPadding: const EdgeInsets.fromLTRB(8, 16, 0, 0),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 20, right: 12),
                child: Icon(Icons.lock_outlined, size: 20),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(left: 20, right: 17),
                child: InkWell(
                  onTap: _toggledocPasswordView,
                  child: Icon(
                    isdocHiddenPassword
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
            height: 20.0,
          ),
          LoginButton('Log In', () async {
            result = await Connectivity().checkConnectivity();
            if (result == ConnectivityResult.mobile ||
                result == ConnectivityResult.wifi) {
              logMeINDoctor();
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
          GestureDetector(
            onTap: () async {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationPage(),
                  ),
                  (route) => route.isFirst);
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setString('login', 'guest');
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
    );
  }
}

class TabBarTabs extends StatelessWidget {
  String text;

  TabBarTabs({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.32,
      child: Center(
        child: Text(
          text,
        ),
      ),
    );
  }
}
