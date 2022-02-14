import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Change%20Notifier/changenotifier.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/UI/BottomNavigation/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourwellbeing/UI/Login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
/*    sharedPreferenceLanguage().whenComplete(
      () async {
        Timer(
          const Duration(seconds: 3),
          () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false);
          },
        );
      },
    );*/
    sharedPreferenceLanguage();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false);
      },
    );
  }

  var languageSharedPreference;
  sharedPreferenceLanguage() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedLanguage = sharedPreferences.getBool('languageData');
    if (obtainedLanguage != null) {
      context.read<DataProvider>().changeString(obtainedLanguage);
    }
    setState(() {
      languageSharedPreference = obtainedLanguage;
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
