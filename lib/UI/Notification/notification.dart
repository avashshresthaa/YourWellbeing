import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/bottomsheet.dart';
import 'package:yourwellbeing/Extracted%20Widgets/buttons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import '../../Extracted Widgets/customtextfield.dart';
import '../../Extracted Widgets/snackbar.dart';
import '../../Utils/user_prefrences.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStyleBackgroundColor,
      appBar: ProfileAppBar(title: 'Notification'),
      body: const NotificationContent(),
    );
  }
}

class NotificationContent extends StatefulWidget {
  const NotificationContent({Key? key}) : super(key: key);

  @override
  _NotificationContentState createState() => _NotificationContentState();
}

class _NotificationContentState extends State<NotificationContent> {
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var title;
  var body;
  var ktitle;
  var kbody;
  var ktime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var initializeAndroid = const AndroidInitializationSettings('app_icon');
    var initialIOS = const IOSInitializationSettings();
    var initialSettings =
        InitializationSettings(android: initializeAndroid, iOS: initialIOS);
    notificationsPlugin.initialize(
      initialSettings,
    );
    _configureTimeZone();

    ktitle = UserSimplePreferences.getTitle() ?? eTitle;
    kbody = UserSimplePreferences.getBody() ?? eBody;
    ktime = UserSimplePreferences.getTime() ?? eTime;
  }

  static tz.TZDateTime _scheduleDaily(int hour, int minutes) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

    return scheduleDate.isBefore(now)
        ? scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }

  Future<void> _configureTimeZone() async {
    tz.initializeTimeZones();
    final String timezone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone));
  }

  Future _showNotification() async {
    var androidDetails = const AndroidNotificationDetails(
      "Channel ID",
      "Name",
      "Description",
      importance: Importance.max,
    );
    var iOSDetails = const IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);

    // var scheduledTime = tz.TZDateTime.now(tz.local).add(
    //   Duration(seconds: 5),
    // );

    DateTime date = DateFormat.jm().parse(_startTime.toString());
    var myTime = DateFormat("HH:mm").format(date);
    print(myTime);
    var hour = int.parse(myTime.toString().split(":")[0]);
    var minutes = int.parse(myTime.toString().split(":")[1]);
    print(hour);
    print(minutes);

    notificationsPlugin.zonedSchedule(1, title, body,
        _scheduleDaily(hour, minutes), generalNotificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  String _startTime = DateFormat('hh:mma').format(DateTime.now()).toString();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  var isPress = false;

  String eTitle = 'No title has been selected yet.';
  String eBody = 'No body has been selected yet.';
  String eTime = 'No time has been selected yet.';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Set an reminder to take your medication.',
                  style: kStyleHomeTitle.copyWith(fontSize: 14.sp),
                ),
                const SizedBox(
                  height: 20,
                ),
                NotificationField(
                  onChanged: (_val) {
                    title = _val;
                  },
                  hintText: 'Title',
                  controller: titleController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Title cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                NotificationField(
                  onChanged: (_val) {
                    body = _val;
                  },
                  hintText: 'Body',
                  controller: bodyController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Body cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: 240,
                  child: TextFormField(
                    validator: (String? value) {
                      if (isPress == false) {
                        return "Please select a date";
                      }
                      return null;
                    },
                    readOnly: true,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    style: const TextStyle(
                      fontFamily: 'NutinoSansReg',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff777777),
                    ),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: kBorder,
                          borderRadius: kBorderRadius,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: kBorder,
                          borderRadius: kBorderRadius,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.red,
                          ),
                          borderRadius: kBorderRadius,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: kBorder,
                          borderRadius: kBorderRadius,
                        ),
                        hintText: isPress == false
                            ? 'Choose time: $_startTime'
                            : 'Selected Time: $_startTime',
                        hintStyle: kStyleTextField,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: -5, horizontal: 8),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            _getTimeFromUser(isStartTime: true);
                            isPress = true;
                            FocusScope.of(context).unfocus();
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: kStyleMainGrey,
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                LoginButton(
                  'Confirm',
                  () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        ktitle = title;
                        kbody = body;
                        ktime = _startTime;
                      });
                      titleController.clear();
                      bodyController.clear();
                      await UserSimplePreferences.setTitle(ktitle);
                      await UserSimplePreferences.setBody(kbody);
                      await UserSimplePreferences.setTime(ktime);
                      _showNotification();
                      showSnackBar(
                        context,
                        "Successful",
                        Colors.green,
                        Icons.info,
                        "Your notification has been set for $_startTime.",
                      );
                    } else {
                      return print("Unsuccessful");
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Your Notification Detail',
                  style: kStyleHomeTitle,
                ),
                const SizedBox(
                  height: 16,
                ),
                alarmDetail(ktitle, kbody, ktime, () {
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
                              ktitle = null;
                              kbody = null;
                              ktime = null;
                            });
                            await notificationsPlugin.cancelAll();
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
            ),
          ),
        ),
      ],
    );
  }
/*
  Future notificationSelected(String? payload) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text('Clicked'),
            ));
  }*/

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formattedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print('time camcnelled');
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formattedTime;
      });
    } else if (isStartTime == false) {}
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split("")[0]),
        ));
  }

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
}
