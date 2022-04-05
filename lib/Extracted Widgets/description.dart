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
