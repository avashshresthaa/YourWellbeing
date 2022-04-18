import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/UI/BottomNavigation/bottom_navigation.dart';
import '../../Extracted Widgets/buttons.dart';

class Receipt extends StatelessWidget {
  Receipt(
      {this.name,
      this.age,
      this.gender,
      this.date,
      this.time,
      this.doctorName,
      this.hospital,
      this.payment,
      this.amount});
  final name, age, gender, date, time, doctorName, hospital, payment, amount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F7FF),
      appBar: AppointmentAppBar(
        title: 'Receipt',
        tap: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(
              height: 16,
            ),
            AspectRatio(
              aspectRatio: 12 / 6,
              child: Image.asset(
                'assets/apreceipt.png',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Don't forget to take a screenshot of this page",
                style: kStyleHomeTitle.copyWith(
                  color: kStyleNavy,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                boxShadow: [boxShadow],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AllDetails(
                      title: 'Name',
                      details: '$name',
                    ),
                    AllDetails(
                      title: 'Age',
                      details: '$age',
                    ),
                    AllDetails(
                      title: 'Sex',
                      details: '$gender',
                    ),
                    AllDetails(
                      title: 'Appointment date',
                      details: '$date',
                    ),
                    AllDetails(
                      title: 'Time',
                      details: '$time',
                    ),
                    AllDetails(
                      title: 'Health Center',
                      details: '$hospital',
                    ),
                    AllDetails(
                      title: 'Doctor Assigned',
                      details: 'Dr. $doctorName',
                    ),
                    AllDetails(
                      title: 'Fee Payment',
                      details: '$payment',
                    ),
                    AllDetails(
                      title: 'Paid Amount',
                      details: '$amount',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'QR Code:',
                          style: kStyleHomeTitle.copyWith(
                            fontSize: 11.sp,
                            fontFamily: 'NutinoSansSemiBold',
                            color: kStyleNavy,
                          ),
                        ),
                        QrImage(
                          data: amount == 'Not Paid'
                              ? '$name will pay through $payment.'
                              : '$name has paid their appointment fee through $payment(Rs.$amount).',
                          size: 100,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ACButton('Go to Home', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BottomNavigationPage();
              }));
            }, kStyleBlue),
          ],
        ),
      ),
    );
  }
}

class AllDetails extends StatelessWidget {
  AllDetails({this.title, this.details});
  final title;
  final details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title: ',
            style: kStyleHomeTitle.copyWith(
              fontSize: 11.sp,
              fontFamily: 'NutinoSansSemiBold',
              color: kStyleNavy,
            ),
          ),
          Text(
            '$details',
            style: kStyleHomeTitle.copyWith(
              fontFamily: 'NutinoSansSemiBold',
              fontSize: 11.sp,
              color: kStyleGrey777,
            ),
          )
        ],
      ),
    );
  }
}
