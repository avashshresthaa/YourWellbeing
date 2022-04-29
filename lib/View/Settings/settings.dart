import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Constraints/nplanguage.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/containlist.dart';
import 'package:yourwellbeing/Extracted%20Widgets/snackbar.dart';
import 'package:yourwellbeing/Network/api_links.dart';
import 'package:yourwellbeing/Utils/user_prefrences.dart';
import 'package:yourwellbeing/View/Change%20Language/change_language.dart';
import 'package:yourwellbeing/View/Change%20Purpose/change_purpose.dart';
import 'package:yourwellbeing/View/Profile/profile.dart';

import '../../Extracted Widgets/showdialog.dart';
import '../Emergency Contacts/emergency.dart';
import '../Notification/notification.dart';

var language;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    // TODO: implement initState
    language = UserSimplePreferences.getLanguage() ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStyleBackgroundColor,
      appBar: MainAppBar('Settings'),
      body: const SettingsContent(),
    );
  }
}

class SettingsContent extends StatefulWidget {
  const SettingsContent({Key? key}) : super(key: key);

  @override
  _SettingsContentState createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  Future<bool> update() async {
    ApiData apiData = ApiData();
    await apiData.updateContent();
    showSnackBar(
      context,
      "Success",
      Colors.green,
      Icons.check_circle,
      "Content Updated Successfully!",
    );
    Navigator.pop(context);
    return true;
  }

  showDialogBox() async {
    {
      var result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        if (update() == true) {
          print("done");
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              Future.delayed(
                Duration(
                    seconds:
                        15), //If there are server error or internet error till 15 sec it will ask to retry
                () {
                  Navigator.of(context).pop(true);
                  print("failed");
                  retrySnackBar(context);
                },
              );
              return AlertDialog(
                title: Center(
                  child: Text(
                    language ? 'Please Wait...' : 'कृपया पर्खनुहोस्',
                    style: kStyleHomeTitle.copyWith(
                        fontWeight: FontWeight.w700, fontSize: 12.sp),
                  ),
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator.adaptive(),
                  ],
                ),
              );
            },
          );
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            children: [
              ContentItems(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Profile();
                  }));
                },
                image: 'assets/profile.png',
                label: 'Profile',
                containerDesignType: 'top',
              ),
              itemDivider(),
              ContentItems(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChangePurpose();
                  }));
                },
                image: 'assets/purpose.png',
                label: 'Change Purpose',
                containerDesignType: 'both',
              ),
              itemDivider(),
              ContentItems(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChangeLanguage();
                  }));
                },
                image: 'assets/language.png',
                label: 'Change Language',
                containerDesignType: 'bottom',
              ),
              const SizedBox(
                height: 16,
              ),
              ContentItems(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const NotificationPage();
                  }));
                },
                image: 'assets/snotification.png',
                label: 'Notification Settings',
                containerDesignType: 'top',
              ),
              itemDivider(),
              ContentItems(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const EmergencyPage();
                  }));
                },
                image: 'assets/scontacts.png',
                label: 'Emergency Contacts',
                containerDesignType: 'both',
              ),
              itemDivider(),
              ContentItems(
                onTap: () async {
                  var result = await Connectivity().checkConnectivity();
                  if (result == ConnectivityResult.mobile ||
                      result == ConnectivityResult.wifi) {
                    if (update() == true) {
                      print("done");
                    } else {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          Future.delayed(
                            Duration(
                                seconds:
                                    15), //If there are server error or internet error till 15 sec it will ask to retry
                            () {
                              Navigator.of(context).pop(true);
                              print("failed");
                              retrySnackBar(context);
                            },
                          );
                          return AlertDialog(
                            title: Center(
                              child: Text(
                                language
                                    ? 'Please Wait...'
                                    : 'कृपया पर्खनुहोस्',
                                style: kStyleHomeTitle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.sp),
                              ),
                            ),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                CircularProgressIndicator.adaptive(),
                              ],
                            ),
                          );
                        },
                      );
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
                },
                image: 'assets/update.png',
                label: 'Update Content',
                containerDesignType: 'both',
              ),
              itemDivider(),
              ContentItems(
                onTap: () {
                  showFeedbackDialog(context);
                },
                image: 'assets/srate.png',
                label: 'Rate Us',
                containerDesignType: 'bottom',
              ),
              /*      ContentItems(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.remove('login');
                  showSnackBar(
                    context,
                    "Successful",
                    Colors.green,
                    Icons.info,
                    "Your notification has been set for ",
                  );
                },
                image: 'assets/menu.png',
                label: 'Log out',
                containerDesignType: 'bottom',
              ),*/
            ],
          ),
        ),
      ],
    );
  }

//Snackbar which shows in case of failure to download content
  void retrySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        'Failed to update the content',
        style: kStyleHomeTitle.copyWith(fontSize: 14, color: Colors.white),
      ),
      action: SnackBarAction(
          label: "Retry",
          textColor: Colors.blue,
          onPressed: () async {
            print('ok');
            await showDialogBox();
          }),
      duration: Duration(days: 1),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
