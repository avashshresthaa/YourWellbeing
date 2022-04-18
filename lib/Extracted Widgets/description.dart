import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';

class DescriptionContent extends StatelessWidget {
  final topic;
  final content;

  DescriptionContent({
    this.topic,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                boxShadow,
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic,
                  style: kStyleHomeTitle,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  content,
                  textAlign: TextAlign.justify,
                  style: kStyleHomeTitle.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
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

class AppointmentTile extends StatelessWidget {
  final String? doctorName;
  final String time;
  final String? hospital;
  final onTap;
  final bool isDoctor;
  AppointmentTile(
      {this.doctorName,
      required this.time,
      required this.hospital,
      this.onTap,
      required this.isDoctor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: Colors.white,
          boxShadow: [
            boxShadow,
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: kStyleBlue, borderRadius: BorderRadius.circular(40)),
              child: Text(
                "${doctorName?.substring(0, 1).toUpperCase()}",
                style: kStyleHomeTitle.copyWith(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isDoctor ? 'Dr. $doctorName' : '$doctorName',
                  style: kStyleHomeTitle.copyWith(
                    color: kStyleGrey333,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  hospital ?? "No Hospital Found",
                  style: kStyleHomeTitle.copyWith(
                    color: kStyleGrey333,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  time,
                  style: kStyleHomeTitle.copyWith(
                    color: kStyleGrey333,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
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
              AspectRatio(
                aspectRatio: 12 / 4,
                child: Image.asset(
                  'assets/noappointment.png',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "You don't have an appointment",
                style: kStyleHomeTitle.copyWith(
                  color: kStyleNavy,
                ),
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
