import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';

class DoctorInfoList extends StatelessWidget {
  DoctorInfoList({this.doctorName, this.speciality, this.rating});
  final doctorName;
  final speciality;
  final rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          boxShadow,
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(40)),
            child: Text(
              "${doctorName?.substring(0, 1).toUpperCase()}",
              style: kStyleHomeTitle.copyWith(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Text(
                'Dr. $doctorName',
                style: kStyleHomeTitle.copyWith(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '$speciality',
                style: kStyleHomeTitle.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '⭐ $rating',
                style: kStyleHomeTitle,
              )
            ],
          ),
        ],
      ),
    );
  }
}
