/*
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/bottomsheet.dart';
import 'package:yourwellbeing/Extracted%20Widgets/snackbar.dart';
import 'package:yourwellbeing/UI/Login/loginpermission.dart';
import 'package:yourwellbeing/Utils/user_prefrences.dart';

class AppointmentList extends StatefulWidget {
  const AppointmentList({Key? key}) : super(key: key);

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  var loginData;

  @override
  void initState() {
    // TODO: implement initState
    loginData = UserSimplePreferences.getLogin() ?? 'guest';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStyleBackgroundColor,
      appBar: ProfileAppBar(title: 'Appointment List'),
      body: loginData == 'guest'
          ? const SignUpContent()
          : const AppointmentListContent(),
    );
  }
}

class AppointmentListContent extends StatefulWidget {
  const AppointmentListContent({Key? key}) : super(key: key);

  @override
  State<AppointmentListContent> createState() => _AppointmentListContentState();
}

class _AppointmentListContentState extends State<AppointmentListContent> {
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Your Notification Detail',
          style: kStyleHomeTitle,
        ),
        const SizedBox(
          height: 16,
        ),
        alarmDetail('sd', 'gg', 'dd', () {
          showModalBottomSheet(
            barrierColor: Colors.green.withOpacity(0.24),
            isScrollControlled: true,
            enableDrag: false,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: DeleteBSheet(
                  () async {
                    setState(() {
                      */
/*         ktitle = null;
                      kbody = null;
                      ktime = null;*/ /*

                    });
                    await notificationsPlugin.cancel(2);
                    await UserSimplePreferences.setTitle(eTitle);
                    await UserSimplePreferences.setBody(eBody);
                    await UserSimplePreferences.setTime(eTime);
                    Navigator.pop(context);
                    showSnackBar(
                      context,
                      "Successful",
                      Colors.green,
                      Icons.info,
                      "Your notification has been deleted.",
                    );
                  },
                ),
              ),
            ),
          );
        })
      ],
    );
  }
}

String eTitle = 'No title has been selected yet.';
String eBody = 'No body has been selected yet.';
String eTime = 'No time has been selected yet.';

Widget alarmDetail(String? title, String? body, String? time, final onPress) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.sp),
      color: Colors.white,
      boxShadow: [boxShadow],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.sp),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Title: ',
                          style: kStyleHomeTitle.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        TextSpan(
                          text: title ?? eTitle,
                          style: kStyleHomeTitle.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onPress,
                  child: Image.asset(
                    'assets/bellcancel.png',
                    color: Colors.red,
                    width: 26,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Body: ',
                        style: kStyleHomeTitle.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                      TextSpan(
                        text: body ?? eBody,
                        style: kStyleHomeTitle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          height: 1.5,
                          color: kStyleCoolGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Time: ',
                        style: kStyleHomeTitle.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                      TextSpan(
                        text: time ?? eTitle,
                        style: kStyleHomeTitle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          height: 1.5,
                          color: kStyleCoolGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
*/
