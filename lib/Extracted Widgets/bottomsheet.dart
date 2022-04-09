import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';

//Imp padding
/*
padding: EdgeInsets.only(
bottom:
MediaQuery.of(context)
.viewInsets
    .bottom),
*/

class DeleteBSheet extends StatelessWidget {
  DeleteBSheet(this.onTap);
  final onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          boxShadow: [boxShadow]),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 24.0, right: 24.0, top: 16, bottom: 32.0),
              child: Column(
                children: [
                  const SizedBox(
                    width: 24,
                    child: Divider(
                      color: Color(0xffA3A3A3),
                      thickness: 2,
                      height: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delete notification',
                        style: kStyleHomeTitle,
                      ),
                      GestureDetector(
                        onTap: onTap,
                        child: Image.asset(
                          'assets/circledelete.png',
                          width: 36,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
