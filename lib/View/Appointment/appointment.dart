import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/APIModels/getAppointments.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:intl/intl.dart';
import 'package:yourwellbeing/Extracted%20Widgets/description.dart';
import 'package:yourwellbeing/Network/NetworkHelper.dart';
import 'package:yourwellbeing/View/Doctor/doctorappointment.dart';
import 'package:yourwellbeing/View/Doctor/searchscreen.dart';
import 'package:yourwellbeing/View/Login/loginpermission.dart';
import 'package:yourwellbeing/View%20Model/changenotifier.dart';
import '../../Utils/user_prefrences.dart';
import 'appointment_content.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  var loginData;
  var userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginData = UserSimplePreferences.getLogin() ?? 'guest';
    userData = UserSimplePreferences.getUserLogin() ?? 'guest';
    print(userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppointmentAppBar(
        title: 'Appointment',
        tap: false,
      ),
      body: userData == 'guest'
          ? const SignUpContent()
          : userData == 'user'
              ? const AppointmentHome()
              : const AppointmentHomeDoc(),
    );
  }
}

class AppointmentHome extends StatelessWidget {
  const AppointmentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 16.0, right: 16.0, bottom: 27.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue.shade200),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 16.0),
                          child: Text('Create a new appointment',
                              textAlign: TextAlign.center,
                              style: kStyleHomeTitle.copyWith(
                                color: Colors.white,
                                fontSize: 13.sp,
                              )),
                        ),
                        Center(
                            child: AspectRatio(
                          aspectRatio: 12 / 6,
                          child: Image.asset(
                            'assets/create.png',
                            height: 225,
                            width: 252,
                          ),
                        )),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppointmentList(),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.only(
                top: 0.0, left: 16.0, right: 16.0, bottom: 27.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue.shade200),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 16.0),
                          child: Text('Appointment Details',
                              textAlign: TextAlign.center,
                              style: kStyleHomeTitle.copyWith(
                                color: Colors.white,
                                fontSize: 13.sp,
                              )),
                        ),
                        Center(
                            child: AspectRatio(
                          aspectRatio: 12 / 6,
                          child: Image.asset(
                            'assets/bookap.png',
                          ),
                        )),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AppointmentList extends StatefulWidget {
  const AppointmentList({Key? key}) : super(key: key);

  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  @override
  void initState() {
    // TODO: implement initState
    getInitialData();
    _appointment = getApiData();
    super.initState();
  }

  getInitialData() async {
    await getCurrentDate();
  }

  Future<AppointmentDetails?>? _appointment;

  late var token = Provider.of<DataProvider>(context, listen: false).tokenValue;

  Future<AppointmentDetails?>? getApiData() async {
    try {
      var posts = await NetworkHelper().getAppointmentDetails(token);
      return posts;
    } catch (e) {
      print('error');
    }
  }

  var dateToday = '';
  var dateTomorrow = '';

  getCurrentDate() {
    var date = DateTime.now();
    var newDate = DateTime(date.year, date.month, date.day + 1);
    convertDateToMonth(date, newDate);
  }

  convertDateToMonth(DateTime formattedDate, DateTime formattedDatePlus1) {
    var formattedDateConverted = DateFormat.yMMMMd().format(formattedDate);
    var formattedDatePlus1Converted =
        DateFormat.yMMMMd().format(formattedDatePlus1);

    setState(() {
      dateToday = formattedDateConverted.toString();
      dateTomorrow = formattedDatePlus1Converted.toString();
    });
    print(dateToday + dateTomorrow);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppointmentAppBar(
        title: 'My Appointments',
        tap: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: ListView(
          physics: ScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          children: [
            FutureBuilder<AppointmentDetails?>(
                future: _appointment,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      height: 800,
                      child: Shimmer.fromColors(
                        direction: ShimmerDirection.ttb,
                        period: const Duration(milliseconds: 8000),
                        child: ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 120,
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black,
                                ),
                              );
                            }),
                        baseColor: const Color(0xFFE5E4E2),
                        highlightColor: Colors.grey.shade400,
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  4,
                                ),
                                boxShadow: [boxShadow]),
                            child: TabBar(
                                isScrollable: true,
                                unselectedLabelStyle: kStyleHomeTitle,
                                indicator: BoxDecoration(
                                    color: kStyleBlue,
                                    borderRadius: BorderRadius.circular(4)),
                                labelColor: Colors.white,
                                labelStyle: kStyleHomeTitle,
                                unselectedLabelColor: kStyleMainGrey,
                                // Tabbar tabs
                                tabs: [
                                  AppointmentTabs(
                                    text: 'Upcoming',
                                  ),
                                  AppointmentTabs(text: 'Past')
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: TabBarView(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                // Today's Appointment Details
                                Text(
                                  'Today, $dateToday',
                                  style: kStyleHomeTitle.copyWith(
                                    color: kStyleGrey777,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                snapshot.data!.appointments!.isEmpty
                                    ? noAppointment()
                                    : ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            snapshot.data!.appointments!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var appointment = snapshot
                                              .data!.appointments![index];
                                          var doctorName =
                                              appointment.doctorName;
                                          var hospitalName =
                                              appointment.hospitalName;
                                          var age = appointment.age;
                                          var dateTime = appointment.datetime!;
                                          var datenow1 = DateTime.now();

                                          var formatteddate =
                                              DateFormat.yMMMMd()
                                                  .format(dateTime)
                                                  .toString();
                                          var day = DateFormat('EEEE')
                                              .format(dateTime)
                                              .toString();
                                          print("day: $day");
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(datenow1);
                                          print("foramtted: $formattedDate");
                                          String formattedDate1 =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(dateTime);
                                          print("foramtted: $formattedDate1");
                                          String formattedTime =
                                              DateFormat('HH:mm')
                                                  .format(dateTime);

                                          var time1 = dateTime
                                              .add(const Duration(hours: 1));
                                          String formattedTime1 =
                                              DateFormat('HH:mm a')
                                                  .format(time1);
                                          if (formattedDate == formattedDate1) {
                                            return GestureDetector(
                                              child: AppointmentTile(
                                                doctorName: doctorName,
                                                time: formattedTime +
                                                    " - " +
                                                    formattedTime1,
                                                hospital: hospitalName,
                                                isDoctor: true,
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return AppointmentContent(
                                                      doctorName: doctorName,
                                                      time: formattedTime +
                                                          " - " +
                                                          formattedTime1,
                                                      date: formatteddate,
                                                      day: day,
                                                      hospital: hospitalName,
                                                      age: age,
                                                      name: appointment.name,
                                                      phone: appointment.phone,
                                                      fee: appointment.payment,
                                                      id: appointment.id,
                                                      isDoctor: true,
                                                      isCancel: true,
                                                    );
                                                  }));
                                                },
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),

                                // Tomorrow's Appointment Details

                                Text(
                                  'Tomorrow, $dateTomorrow',
                                  style: kStyleHomeTitle.copyWith(
                                    color: kStyleGrey777,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                snapshot.data!.appointments!.isEmpty
                                    ? noAppointment()
                                    : ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            snapshot.data!.appointments!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var appointment = snapshot
                                              .data!.appointments![index];
                                          var doctorName =
                                              appointment.doctorName;
                                          var hospitalName =
                                              appointment.hospitalName;

                                          var date1Time = appointment.datetime!;
                                          var datenow1 = DateTime.now();

                                          var date1 = datenow1
                                              .add(const Duration(days: 1));
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(date1);
                                          String formattedDate1 =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(date1Time);

                                          String formattedTime =
                                              DateFormat('HH:mm').format(
                                                  appointment.datetime!);

                                          var time1 = appointment.datetime
                                              ?.add(const Duration(hours: 1));
                                          String formattedTime1 =
                                              DateFormat('HH:mm a')
                                                  .format(time1!);
                                          var day = DateFormat('EEEE')
                                              .format(date1Time)
                                              .toString();

                                          var formatteddate =
                                              DateFormat.yMMMMd()
                                                  .format(date1Time)
                                                  .toString();

                                          if (formattedDate == formattedDate1) {
                                            return AppointmentTile(
                                              doctorName: doctorName,
                                              time: formattedTime +
                                                  " - " +
                                                  formattedTime1,
                                              hospital: hospitalName,
                                              isDoctor: true,
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return AppointmentContent(
                                                    doctorName: doctorName,
                                                    time: formattedTime +
                                                        " - " +
                                                        formattedTime1,
                                                    date: formatteddate,
                                                    day: day,
                                                    hospital: hospitalName,
                                                    age: appointment.age,
                                                    name: appointment.name,
                                                    phone: appointment.phone,
                                                    fee: appointment.payment,
                                                    id: appointment.id,
                                                    isDoctor: true,
                                                    isCancel: true,
                                                  );
                                                }));
                                              },
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }),

                                // Upcoming's Appointment Details
                                Text(
                                  'Upcoming',
                                  style: kStyleHomeTitle.copyWith(
                                    color: kStyleGrey777,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Expanded(
                                  child: snapshot.data!.appointments!.isEmpty
                                      ? noAppointment()
                                      : ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: snapshot
                                              .data!.appointments!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var appointment = snapshot
                                                .data!.appointments![index];
                                            var doctorName =
                                                appointment.doctorName;
                                            var hospitalName =
                                                appointment.hospitalName;

                                            var dateTime =
                                                appointment.datetime.toString();
                                            var datenow =
                                                DateTime.now().toString();
                                            DateTime dt1 =
                                                DateTime.parse(dateTime);
                                            DateTime dt2 =
                                                DateTime.parse(datenow);

                                            var datenow1 = DateTime.now();
                                            var date1 = datenow1
                                                .add(const Duration(days: 1));
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(date1);
                                            String formattedDate1 =
                                                DateFormat('yyyy-MM-dd').format(
                                                    appointment.datetime!);

                                            String formattedTime =
                                                DateFormat('HH:mm').format(
                                                    appointment.datetime!);

                                            var time1 = appointment.datetime
                                                ?.add(const Duration(hours: 1));
                                            String formattedTime1 =
                                                DateFormat('HH:mm a')
                                                    .format(time1!);

                                            var day = DateFormat('EEEE')
                                                .format(appointment.datetime!)
                                                .toString();

                                            var formatteddate =
                                                DateFormat.yMMMMd()
                                                    .format(
                                                        appointment.datetime!)
                                                    .toString();

                                            if (formattedDate !=
                                                    formattedDate1 &&
                                                dt1.isAfter(dt2)) {
                                              return AppointmentTile(
                                                doctorName: doctorName,
                                                time: formattedTime +
                                                    " - " +
                                                    formattedTime1,
                                                hospital: hospitalName,
                                                isDoctor: true,
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return AppointmentContent(
                                                      doctorName: doctorName,
                                                      time: formattedTime +
                                                          " - " +
                                                          formattedTime1,
                                                      date: formatteddate,
                                                      day: day,
                                                      hospital: hospitalName,
                                                      age: appointment.age,
                                                      name: appointment.name,
                                                      phone: appointment.phone,
                                                      fee: appointment.payment,
                                                      id: appointment.id,
                                                      isDoctor: true,
                                                      isCancel: true,
                                                    );
                                                  }));
                                                },
                                              );
                                            } else {
                                              return Container();
                                            }
                                          }),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'Past History',
                                  style: kStyleHomeTitle.copyWith(
                                    color: kStyleGrey777,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                snapshot.data!.appointments!.isEmpty
                                    ? noAppointment()
                                    : Expanded(
                                        child: ListView.builder(
                                            padding:
                                                EdgeInsets.only(bottom: 16),
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: snapshot
                                                .data!.appointments!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var appointment = snapshot
                                                  .data!.appointments![index];
                                              var doctorName =
                                                  appointment.doctorName;
                                              var hospitalName =
                                                  appointment.hospitalName;
                                              var problem =
                                                  appointment.describeProblem;
                                              var dateTime = appointment
                                                  .datetime
                                                  .toString();
                                              var datenow =
                                                  DateTime.now().toString();

                                              DateTime dt1 =
                                                  DateTime.parse(dateTime);
                                              DateTime dt2 =
                                                  DateTime.parse(datenow);
                                              var datenow1 = DateTime.now();
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(datenow1);
                                              String formattedDate1 =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(appointment
                                                          .datetime!);
                                              String formattedTime =
                                                  DateFormat('HH:mm').format(
                                                      appointment.datetime!);

                                              var time1 = appointment.datetime
                                                  ?.add(
                                                      const Duration(hours: 1));
                                              String formattedTime1 =
                                                  DateFormat('HH:mm a')
                                                      .format(time1!);

                                              var day = DateFormat('EEEE')
                                                  .format(appointment.datetime!)
                                                  .toString();

                                              var formatteddate =
                                                  DateFormat.yMMMMd()
                                                      .format(
                                                          appointment.datetime!)
                                                      .toString();

                                              if (formattedDate !=
                                                      formattedDate1 &&
                                                  dt2.isAfter(dt1)) {
                                                return AppointmentTile(
                                                  doctorName: doctorName,
                                                  time: formattedTime +
                                                      " - " +
                                                      formattedTime1,
                                                  hospital: hospitalName,
                                                  isDoctor: true,
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return AppointmentContent(
                                                        doctorName: doctorName,
                                                        time: formattedTime +
                                                            " - " +
                                                            formattedTime1,
                                                        date: formatteddate,
                                                        day: day,
                                                        hospital: hospitalName,
                                                        age: appointment.age,
                                                        name: appointment.name,
                                                        phone:
                                                            appointment.phone,
                                                        fee:
                                                            appointment.payment,
                                                        isDoctor: true,
                                                        isCancel: false,
                                                      );
                                                    }));
                                                  },
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      ),
                              ],
                            ),
                          ]),
                        ),
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class AppointmentTabs extends StatelessWidget {
  String text;

  AppointmentTabs({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.37,
      child: Center(
        child: Text(
          text,
        ),
      ),
    );
  }
}
