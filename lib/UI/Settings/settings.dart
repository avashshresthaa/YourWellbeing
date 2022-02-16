import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/containlist.dart';
import 'package:yourwellbeing/Extracted%20Widgets/snackbar.dart';
import 'package:yourwellbeing/UI/Change%20Language/change_language.dart';
import 'package:yourwellbeing/UI/Change%20Purpose/change_purpose.dart';
import 'package:yourwellbeing/UI/Profile/profile.dart';

import '../../Extracted Widgets/showdialog.dart';
import '../Emergency Contacts/emergency.dart';
import '../Notification/notification.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                image: 'assets/menu.png',
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
                image: 'assets/menu.png',
                label: 'Emergency Contacts',
                containerDesignType: 'both',
              ),
              itemDivider(),
              ContentItems(
                onTap: () {
                  showWaitDialog(context);
                },
                image: 'assets/menu.png',
                label: 'Update Content',
                containerDesignType: 'both',
              ),
              itemDivider(),
              ContentItems(
                onTap: () {
                  showFeedbackDialog(context);
                },
                image: 'assets/menu.png',
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
}
