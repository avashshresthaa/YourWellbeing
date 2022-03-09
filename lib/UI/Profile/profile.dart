import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/buttons.dart';
import 'package:yourwellbeing/Extracted%20Widgets/containlist.dart';
import 'package:yourwellbeing/Services/authentication.dart';
import 'package:yourwellbeing/UI/Emergency%20Contacts/emergency.dart';
import 'package:yourwellbeing/UI/Login/login.dart';
import 'package:yourwellbeing/UI/Login/loginpermission.dart';
import 'package:yourwellbeing/Utils/user_prefrences.dart';
import 'package:yourwellbeing/Constraints/uppercase.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

var username;
var email;

class _ProfileState extends State<Profile> {
  var loginData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = UserSimplePreferences.getUserName() ?? "User";
    email = UserSimplePreferences.getUserEmail() ?? "abc@gmail.com";

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
  AuthMethods authMethods = AuthMethods();
  var titleName = username.toString().toTitleCase();

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
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: Colors.white,
                              boxShadow: [
                                boxShadow,
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: Text(
                                    "${username?.substring(0, 1).toUpperCase()}",
                                    style: kStyleHomeTitle.copyWith(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Username: ${titleName}",
                                      style: kStyleHomeTitle.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff444647)),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Email: ${email}",
                                      style: kStyleButtonContent,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                      image: 'assets/menu.png',
                      label: 'My Appointment List',
                      containerDesignType: 'top',
                    ),
                    itemDivider(),
                    ContentItems(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const EmergencyPage();
                        }));
                      },
                      image: 'assets/menu.png',
                      label: 'Emergency Contacts',
                      containerDesignType: 'both',
                    ),
                    itemDivider(),
                    ContentItems(
                        onTap: () {},
                        image: 'assets/menu.png',
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
                    authMethods.signOut();
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.remove('login');
                    pref.remove("usernameKey");
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                  arrow: 'assets/redarrow.png',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
