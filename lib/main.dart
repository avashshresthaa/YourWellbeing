import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yourwellbeing/Splash%20Screen/splashscreen.dart';
import 'Change Notifier/changenotifier.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'Utils/user_prefrences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();
  await Firebase.initializeApp();
  runApp(const YourWellBeing());
}

class YourWellBeing extends StatelessWidget {
  const YourWellBeing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.green,
        systemNavigationBarColor: Colors.black,
      ),
    );

    return Sizer(
      builder: (context, orientation, deviceType) {
        return ChangeNotifierProvider<DataProvider>(
          create: (context) => DataProvider(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            initialRoute: '/',
            routes: <String, WidgetBuilder>{
              '/': (context) => const SplashScreen(),
            },
            /*home: const LoginPage(),*/
          ),
        );
      },
    );
  }
}
