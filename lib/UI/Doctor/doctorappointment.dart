import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/APIModels/getAppointments.dart';
import 'package:yourwellbeing/APIModels/getDoctorAppointments.dart';
import 'package:yourwellbeing/Change%20Notifier/changenotifier.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:intl/intl.dart';
import 'package:yourwellbeing/Extracted%20Widgets/description.dart';
import 'package:yourwellbeing/Network/NetworkHelper.dart';
import 'package:yourwellbeing/UI/Appointment/appointment.dart';
import 'package:yourwellbeing/UI/Appointment/appointment_content.dart';

class AppointmentHomeDoc extends StatelessWidget {
  const AppointmentHomeDoc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppointmentListDoc(),
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
      ],
    );
  }
}

class AppointmentListDoc extends StatefulWidget {
  const AppointmentListDoc({Key? key}) : super(key: key);

  @override
  State<AppointmentListDoc> createState() => _AppointmentListDocState();
}

class _AppointmentListDocState extends State<AppointmentListDoc> {
  @override
  void initState() {
    // TODO: implement initState
    getInitialData();
    _doctorappointment = getApiData();
    super.initState();
  }

  getInitialData() async {
    await getCurrentDate();
  }

  Future<AppointmentDoctorDetails?>? _doctorappointment;

  late var token = Provider.of<DataProvider>(context, listen: false).tokenValue;

  Future<AppointmentDoctorDetails?>? getApiData() async {
    try {
      var posts = await NetworkHelper().getDoctorAppointmentDetails(token);
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

  Widget noAppointment() {
    return Column(
      children: [
        Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/noappointment.png',
                  width: 60,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "You don't have an appointment",
                  style: kStyleHomeTitle,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 6,
        ),
      ],
    );
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
          padding: const EdgeInsets.all(16.0),
          children: [
            FutureBuilder<AppointmentDoctorDetails?>(
                future: _doctorappointment,
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
                                                doctorName: appointment.name,
                                                time: formattedTime +
                                                    " - " +
                                                    formattedTime1,
                                                hospital: hospitalName,
                                                isDoctor: false,
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return AppointmentContent(
                                                      doctorName:
                                                          appointment.name,
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
                                                      description: appointment
                                                          .describeProblem,
                                                      isDoctor: false,
                                                      isCancel: false,
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
                                              doctorName: appointment.name,
                                              time: formattedTime +
                                                  " - " +
                                                  formattedTime1,
                                              hospital: hospitalName,
                                              isDoctor: false,
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return AppointmentContent(
                                                    doctorName:
                                                        appointment.name,
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
                                                    description: appointment
                                                        .describeProblem,
                                                    isDoctor: false,
                                                    isCancel: false,
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
                                snapshot.data!.appointments!.isEmpty
                                    ? noAppointment()
                                    : Expanded(
                                        child: ListView.builder(
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
                                              var date1 = datenow1
                                                  .add(const Duration(days: 1));
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(date1);
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
                                                  dt1.isAfter(dt2)) {
                                                return AppointmentTile(
                                                  doctorName: appointment.name,
                                                  time: formattedTime +
                                                      " - " +
                                                      formattedTime1,
                                                  hospital: hospitalName,
                                                  isDoctor: false,
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return AppointmentContent(
                                                        doctorName:
                                                            appointment.name,
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
                                                        id: appointment.id,
                                                        description: appointment
                                                            .describeProblem,
                                                        isDoctor: false,
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
                                                  doctorName: appointment.name,
                                                  time: formattedTime +
                                                      " - " +
                                                      formattedTime1,
                                                  hospital: hospitalName,
                                                  isDoctor: false,
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return AppointmentContent(
                                                        doctorName:
                                                            appointment.name,
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
                                                        description: appointment
                                                            .describeProblem,
                                                        isDoctor: false,
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
