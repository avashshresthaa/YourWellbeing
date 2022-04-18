import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourwellbeing/APIModels/deleteAppointment.dart';
import 'package:yourwellbeing/Change%20Notifier/changenotifier.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Constraints/nplanguage.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/buttons.dart';
import 'package:yourwellbeing/Extracted%20Widgets/description.dart';
import 'package:yourwellbeing/Extracted%20Widgets/showdialog.dart';
import 'package:yourwellbeing/Extracted%20Widgets/snackbar.dart';
import 'package:yourwellbeing/Network/NetworkHelper.dart';
import 'package:yourwellbeing/UI/Appointment/appointment.dart';
import 'package:yourwellbeing/UI/Doctor/doctorappointment.dart';
import 'package:yourwellbeing/UI/Home/home.dart';
import 'package:yourwellbeing/Utils/user_prefrences.dart';

class AppointmentContent extends StatefulWidget {
  final doctorName;
  final time;
  final date;
  final day;
  final hospital;
  final age;
  final name;
  final phone;
  final fee;
  final id;
  final description;
  final bool isCancel;
  final bool isDoctor;

  AppointmentContent({
    this.doctorName,
    this.time,
    this.date,
    this.day,
    this.hospital,
    this.age,
    this.name,
    this.phone,
    this.fee,
    this.id,
    this.description,
    required this.isCancel,
    required this.isDoctor,
  });

  @override
  State<AppointmentContent> createState() => _AppointmentContentState();
}

class _AppointmentContentState extends State<AppointmentContent> {
  var language;

  @override
  void initState() {
    // TODO: implement initState
    language = UserSimplePreferences.getLanguage() ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppointmentAppBar(
        title: "My Appointments",
        tap: true,
      ),
      body: Stack(
        children: [
          ListView(
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              AppointmentTile(
                doctorName: widget.doctorName,
                time: widget.time,
                hospital: widget.hospital,
                isDoctor: widget.isDoctor ? true : false,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(
                          4.0) //                 <--- border radius here
                      ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visiting Time',
                      style: kStyleHomeTitle,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.hospital,
                      style: kStyleHomeTitle.copyWith(
                        fontFamily: 'NutinoSansSemiBold',
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.day + ', ',
                          style: kStyleHomeTitle.copyWith(
                            fontFamily: 'NutinoSansSemiBold',
                          ),
                        ),
                        Text(
                          widget.date,
                          style: kStyleHomeTitle.copyWith(
                            fontFamily: 'NutinoSansSemiBold',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.time,
                      style: kStyleHomeTitle.copyWith(
                        fontFamily: 'NutinoSansSemiBold',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(
                          4.0) //                 <--- border radius here
                      ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Patient Information',
                      style: kStyleHomeTitle,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    widget.isDoctor
                        ? Column(
                            children: [
                              Text(
                                'Full Name:  ' + widget.name,
                                style: kStyleHomeTitle.copyWith(
                                  fontFamily: 'NutinoSansSemiBold',
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          )
                        : Container(),
                    Text(
                      'Age:  ' + widget.age,
                      style: kStyleHomeTitle.copyWith(
                        fontFamily: 'NutinoSansSemiBold',
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Phone:  ' + widget.phone,
                      style: kStyleHomeTitle.copyWith(
                        fontFamily: 'NutinoSansSemiBold',
                      ),
                    ),
                    widget.isDoctor
                        ? Container()
                        : Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Description:  ' + widget.description,
                                style: kStyleHomeTitle.copyWith(
                                  fontFamily: 'NutinoSansSemiBold',
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(
                          4.0) //                 <--- border radius here
                      ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fee Information',
                      style: kStyleHomeTitle,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.fee,
                      style: kStyleHomeTitle.copyWith(
                        fontFamily: 'NutinoSansSemiBold',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          widget.isCancel == true
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ACButton(
                      'Cancel Appointment',
                      () async {
                        showDialog(
                          barrierColor: Colors.blueAccent.withOpacity(0.3),
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: <Widget>[
                              FittedBox(
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 12 / 4,
                                        child: Image.asset(
                                          'assets/bookap.png',
                                        ),
                                      ),
                                      Text(
                                        "Attention",
                                        style: kStyleHomeTitle.copyWith(
                                            fontSize: 20,
                                            decoration: TextDecoration.none),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Are you sure you want to delete your appointment?",
                                        textAlign: TextAlign.center,
                                        style: kStyleHomeTitle.copyWith(
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none),
                                      ),
                                      const SizedBox(height: 28),
                                      blueButton(
                                        Text(
                                          'Yes',
                                          style: kStyleHomeTitle.copyWith(
                                              decoration: TextDecoration.none,
                                              color: Colors.white),
                                        ),
                                        () async {
                                          late var token =
                                              Provider.of<DataProvider>(context,
                                                      listen: false)
                                                  .tokenValue;

                                          Navigator.pop(context);
                                          showWaitDialog(
                                              context,
                                              language
                                                  ? 'Please Wait...'
                                                  : nepWait);

                                          DeleteData? delete = await NetworkHelper()
                                              .deleteAppointmentData(
                                                  'http://10.0.2.2:80/fypapi/public/api/appointment/${widget.id}/delete',
                                                  token);
                                          print('dekete');

                                          Future.delayed(
                                            const Duration(
                                                seconds:
                                                    2), //If there are server error or internet error till 15 sec it will ask to retry
                                            () {
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      const AppointmentList(),
                                                ),
                                                (route) => route.isFirst,
                                              );
                                              widget.fee == 'Cash'
                                                  ? showSnackBar(
                                                      context,
                                                      "Attention",
                                                      Colors.green,
                                                      Icons.info,
                                                      delete?.message ??
                                                          'Deleted',
                                                    )
                                                  : showSnackBar(
                                                      context,
                                                      "Appointment Deleted",
                                                      Colors.green,
                                                      Icons.info,
                                                      'Your money will be refunded soon.',
                                                    );
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 14),
                                      whiteButton('No', () {
                                        Navigator.pop(context);
                                      }),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      Colors.red,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
