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

Widget appointmentDetail(
    String? title, String? body, String? time, final onPress) {
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
                          text: 'Doctor Name: ',
                          style: kStyleHomeTitle.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        TextSpan(
                          text: title,
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
                    'assets/circledelete.png',
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
                        text: 'Hospital Name: ',
                        style: kStyleHomeTitle.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                      TextSpan(
                        text: body,
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
                        text: 'Description Problem: ',
                        style: kStyleHomeTitle.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                      TextSpan(
                        text: time,
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
