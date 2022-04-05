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
import 'package:yourwellbeing/UI/Appointment/appointment_list.dart';
import 'package:yourwellbeing/UI/Doctor/searchscreen.dart';
import 'package:yourwellbeing/UI/Login/loginpermission.dart';
import '../../Extracted Widgets/customtextfield.dart';
import '../../Extracted Widgets/snackbar.dart';
import '../../Utils/user_prefrences.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
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
      appBar: SChatAppBar(
        title: 'Appointment',
        onTap: () {
          loginData == 'guest'
              ? showSnackBar(
                  context,
                  "Attention",
                  Colors.red,
                  Icons.info,
                  "Login Required",
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ));
        },
      ),
      body: loginData == 'guest'
          ? const SignUpContent()
          : const AppointmentDetails(),
    );
  }
}

class AppointmentDetails extends StatelessWidget {
  const AppointmentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          "Appointment List",
          style: kStyleHomeTitle,
        ),
      ],
    );
  }
}

class AppointmentContent extends StatefulWidget {
  const AppointmentContent({Key? key}) : super(key: key);

  @override
  _AppointmentContentState createState() => _AppointmentContentState();
}

class _AppointmentContentState extends State<AppointmentContent> {
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
        ? scheduleDate.add(const Duration(days: 3600))
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

    notificationsPlugin.zonedSchedule(
        2,
        'Appointment Reminder',
        "Don't miss out your appointment",
        _scheduleDaily(hour, minutes),
        generalNotificationDetails,
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
}
