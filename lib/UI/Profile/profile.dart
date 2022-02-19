import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/buttons.dart';
import 'package:yourwellbeing/Extracted%20Widgets/containlist.dart';
import 'package:yourwellbeing/UI/Login/login.dart';
import 'package:yourwellbeing/UI/Login/loginpermission.dart';
import 'package:yourwellbeing/Utils/user_prefrences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var loginData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginData = UserSimplePreferences.getLogin() ?? 'guest';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStyleBackgroundColor,
      appBar: ProfileAppBar(
        title: 'Profile',
      ),
      body: loginData == 'guest' ? const SignUpContent() : ProfileContent(),
    );
  }
}

class ProfileContent extends StatefulWidget {
  const ProfileContent({Key? key}) : super(key: key);

  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 34.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jane Doe',
                              style: kStyleHomeTitle.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff444647)),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'No. 123, Sub Street',
                              style: kStyleButtonContent,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //Profile Menu Items
              Padding(
                padding: const EdgeInsets.only(top: 33.0, bottom: 24),
                child: Column(
                  children: [
                    ContentItems(
                      onTap: () {},
                      image: 'assets/Profile/menu.png',
                      label: 'My Appointment List',
                      containerDesignType: 'top',
                    ),
                    itemDivider(),
                    ContentItems(
                      onTap: () {},
                      image: 'assets/Profile/shipment.png',
                      label: 'Emergency Contacts',
                      containerDesignType: 'both',
                    ),
                    itemDivider(),
                    ContentItems(
                        onTap: () {},
                        image: 'assets/Profile/invfrens.png',
                        label: 'Invite Friends',
                        containerDesignType: 'bottom'),
                  ],
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ArrowButton(
                  text: Text(
                    'Logout',
                    textAlign: TextAlign.center,
                    style: kStyleButtonContent.copyWith(color: Colors.white),
                  ),
                  color: Color(0xffFF3D3D),
                  onPress: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.remove('login');
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                  arrow: 'assets/forwardarrow.png',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
