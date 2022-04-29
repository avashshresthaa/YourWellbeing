import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Constraints/nplanguage.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourwellbeing/Extracted%20Widgets/showdialog.dart';
import 'package:yourwellbeing/Extracted%20Widgets/snackbar.dart';
import 'package:yourwellbeing/Network/api_links.dart';
import 'package:yourwellbeing/View/BottomNavigation/bottom_navigation.dart';
import 'package:yourwellbeing/Utils/user_prefrences.dart';
import '../../Extracted Widgets/buttons.dart';

class ChangePurpose extends StatefulWidget {
  @override
  _ChangePurposeState createState() => _ChangePurposeState();
}

class _ChangePurposeState extends State<ChangePurpose> {
  var language;
  var purpose;
  var obtainedMethod;
  var internetButNoInternet;
  //bool? showTheDialog = true;
  ConnectivityResult result = ConnectivityResult.none;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    purpose = UserSimplePreferences.getPurpose();
    language = UserSimplePreferences.getLanguage() ?? true;

    print(purpose);
    saveDialogValue().whenComplete(() {
      //after checking saveDialogValue which checks obMethod and interntButNoInternet. It will check if it is null or not
      if (obtainedMethod == null || internetButNoInternet == null) {
        downloadContent();
        /* retrySnackBar(context);*/
      }
    });
  }

  //calls the snackbarFunction which will call the download class
  Future downloadContent() async {
    if (snackBarFunction() == true) {
      //if download is complete it wont show anything here
      print("done");
    } else {
      _showDialog(); //while the download is happening it will show this and any error handling is done in the method
    }
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      sharedPreferences.setString('show',
          'download'); //When this downloadContent is called it sets the show
    }
  }

  //Calls the api_links.dart ApiData class and downloads data
  Future<bool> snackBarFunction() async {
    ApiData apiData = ApiData();
    await apiData.downloadData().whenComplete(() async {});
    showSnackBar(
      context,
      "Success",
      Colors.green,
      Icons.check_circle,
      "Content Downloaded Successfully!",
    ); //When the download completes this will be shown
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.setString('internetButNoInternet',
        'internetButNoInternet'); //When the download completes internetButNOInternet is no longer null
    print("Download Success");
    Navigator.pop(context);
    return true;
  }

  _showDialog() async {
    result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      showWaitDialog(context, language ? 'Please Wait...' : nepWait);
    } else {
      print("Failed");
      showDialog(
        barrierColor: Colors.blueAccent.withOpacity(0.3),
        barrierDismissible: false,
        context: context,
        builder: (_) => Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: <Widget>[
            FittedBox(
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100]),
                padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/nowifi.png',
                      width: 91,
                    ),
                    Text(
                      "Connection Problem",
                      style: kStyleHomeTitle.copyWith(
                          fontSize: 20, decoration: TextDecoration.none),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "We’re having difficulty connecting to\nthe sever. Check your connection or try\nagain later.",
                      textAlign: TextAlign.center,
                      style: kStyleHomeTitle.copyWith(
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(height: 28),
                    LoginButton(
                      'Retry',
                      () async {
                        result = await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.mobile ||
                            result == ConnectivityResult.wifi) {
                          Navigator.of(context, rootNavigator: true).pop();
                          downloadContent();
                        } else {
                          showSnackBar(
                            context,
                            "Attention",
                            Colors.blue,
                            Icons.info,
                            "You must be connected to the internet.",
                          );
                        }
                      },
                    ),
                    SizedBox(height: 14),
                    LoginButton(
                      'Exit',
                      () {
                        SystemNavigator.pop();
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  //Tries to find if the show and internetbutnointernet is null or not
  Future saveDialogValue() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainMethod = sharedPreferences.getString('show');
    var fullInternetCheck =
        sharedPreferences.getString('internetButNoInternet');
    setState(() {
      obtainedMethod = obtainMethod;
      internetButNoInternet = fullInternetCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: purpose == null
          ? AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Select Your Purpose',
                style: kStyleAppBar,
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
            )
          : ProfileAppBar(title: 'Change Purpose'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Select Your Purpose',
            style: kStyleHomeTitle.copyWith(
              fontSize: 18.sp,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            'Welcome, User',
            style: kStyleHomeTitle.copyWith(
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Please select your preferable purpose.',
            style: kStyleTextField.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            children: [
              LangButton(
                () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('choosePreference', 'covid');

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      /*            settings: RouteSettings(name: '/1'),*/
                      builder: (context) => BottomNavigationPage(),
                    ),
                    ModalRoute.withName('/'),
                  );
                },
                'Covid-19',
              ),
              const SizedBox(
                height: 16,
              ),
              LangButton(() async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('choosePreference', 'influenza');

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    /*            settings: RouteSettings(name: '/1'),*/
                    builder: (context) => BottomNavigationPage(),
                  ),
                  ModalRoute.withName('/'),
                );
              }, 'Influenza'),
            ],
          ),
        ],
      ),
    );
  }
}
