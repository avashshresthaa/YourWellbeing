import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/src/provider.dart';
import 'package:yourwellbeing/Change%20Notifier/changenotifier.dart';
import 'package:yourwellbeing/UI/BottomNavigation/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    sharedPreferenceLanguage();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const BottomNavigation(),
          ),
        );
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
            children: const [
              Image(
                image: AssetImage('assets/splash.png'),
                height: 64,
                width: 230,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 72),
              SpinKitThreeBounce(
                color: Color(0xff0582CA),
                size: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
