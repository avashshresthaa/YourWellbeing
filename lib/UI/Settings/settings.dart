import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/UI/Change%20Language/change_language.dart';
import 'package:yourwellbeing/UI/Change%20Purpose/change_purpose.dart';

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
              SettingsItems(
                onTap: () {},
                image: 'assets/profile.png',
                label: 'Profile',
                containerDesignType: 'top',
              ),
              itemDivider(),
              SettingsItems(
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
              SettingsItems(
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
              SettingsItems(
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
              SettingsItems(
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
              SettingsItems(
                onTap: () {
                  showWaitDialog(context);
                },
                image: 'assets/menu.png',
                label: 'Update Content',
                containerDesignType: 'both',
              ),
              itemDivider(),
              SettingsItems(
                onTap: () {
                  showFeedbackDialog(context);
                },
                image: 'assets/menu.png',
                label: 'Rate Us',
                containerDesignType: 'bottom',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget itemDivider() {
    return const SizedBox(
      width: double.infinity,
      height: 0,
      child: Divider(
        color: Color(0xffD8DDE0),
        thickness: 1,
      ),
    );
  }
}

class SettingsItems extends StatelessWidget {
  SettingsItems(
      {Key? key,
      required this.image,
      required this.label,
      required this.containerDesignType,
      required this.onTap})
      : super(key: key);

  final image;
  final label;
  final containerDesignType;
  final onTap;

  final kRadius = Radius.circular(8.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            containerDesignType == "bottom" ? boxShadow : const BoxShadow(),
          ],
          borderRadius: containerDesignType == "top"
              ? BorderRadius.only(topLeft: kRadius, topRight: kRadius)
              : containerDesignType == "bottom"
                  ? BorderRadius.only(bottomLeft: kRadius, bottomRight: kRadius)
                  : containerDesignType == "both"
                      ? const BorderRadius.all(Radius.circular(0.0))
                      : const BorderRadius.all(Radius.circular(0.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(height: 22, width: 22, child: Image.asset(image)),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    label,
                    style: kStyleButtonContent.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: 22,
                  width: 22,
                  child: Image.asset('assets/forwardarrow.png'))
            ],
          ),
        ),
      ),
    );
  }
}
