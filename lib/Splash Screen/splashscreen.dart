import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourwellbeing/UI/BottomNavigation/bottom_navigation.dart';
import 'package:yourwellbeing/UI/Change%20Purpose/change_purpose.dart';
import 'package:yourwellbeing/UI/Login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  var loginSharedPreference;
  var purposeSharedPreference;

  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPreferencePurpose();
    sharedPreferenceLogin();
/*    sharedPreferenceLogin().whenComplete(
      () async {
        Timer(
          const Duration(seconds: 3),
          () {
            purposeSharedPreference = Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => loginSharedPreference == null
                        ? LoginPage()
                        : (purposeSharedPreference == null
                            ? ChangePurpose()
                            : (purposeSharedPreference == 'covid'
                                ? BottomNavigationPage()
                                : purposeSharedPreference == 'influenza'
                                    ? BottomNavigationPage()
                                    : ChangePurpose()))),
                (Route<dynamic> route) => false);
          },
        );
        print(loginSharedPreference);
      },
    );*/
    Timer(
      const Duration(seconds: 3),
      () {
/*        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => loginSharedPreference == null
                    ? LoginPage()
                    : (purposeSharedPreference == null
                        ? ChangePurpose()
                        : (purposeSharedPreference == 'covid'
                            ? BottomNavigationPage()
                            : purposeSharedPreference == 'influenza'
                                ? BottomNavigationPage()
                                : ChangePurpose()))),
            (Route<dynamic> route) => false);*/
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => (purposeSharedPreference == null
                    ? ChangePurpose()
                    : (purposeSharedPreference == 'covid'
                        ? BottomNavigationPage()
                        : purposeSharedPreference == 'influenza'
                            ? BottomNavigationPage()
                            : ChangePurpose()))),
            (Route<dynamic> route) => false);
      },
    );
  }

  sharedPreferencePurpose() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedPurpose = sharedPreferences.getString('choosePreference');
    setState(() {
      purposeSharedPreference = obtainedPurpose;
      print(purposeSharedPreference);
    });
  }

  Future sharedPreferenceLogin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedLogin = sharedPreferences.getString('login');

    setState(() {
      loginSharedPreference = obtainedLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/logo.png'),
                height: 200,
                width: 200,
                fit: BoxFit.fill,
              ),
              Text(
                'Your Wellbeing',
                style: kStyleAppBar.copyWith(
                    fontWeight: FontWeight.w700, fontSize: 20.sp),
              ),
              Text(
                'Mobile App',
                style: kStyleAppBar.copyWith(
                    fontWeight: FontWeight.w700, fontSize: 18.sp),
              ),
              const SizedBox(height: 40),
              const SpinKitWave(
                color: Colors.green,
                size: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
