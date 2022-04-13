import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/UI/Appointment/applist.dart';
import 'package:yourwellbeing/UI/Doctor/searchscreen.dart';
import 'package:yourwellbeing/UI/Login/login.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Future<void> showWaitDialog(BuildContext context, String text) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Center(
          child: Text(
            text,
            style: kStyleHomeTitle.copyWith(
                fontWeight: FontWeight.w700, fontSize: 12.sp),
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator.adaptive(),
          ],
        ),
      ),
    );

Future<void> showBackDialog(BuildContext context) => showDialog(
      barrierColor: Colors.green.withOpacity(0.24),
      barrierDismissible: false,
      context: context,
      builder: (_) => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 145,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100]),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Are you sure you want to exit?",
                    style: kStyleShowDialog,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          /*    willLeave = false;*/
                          SystemNavigator.pop();
                        },
                        child: Text(
                          "Yes",
                          style: kStyleShowDialog.copyWith(fontSize: 12.sp),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "No",
                          style: kStyleShowDialog.copyWith(fontSize: 12.sp),
                        ),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );

Future<void> showLoginDialog(
  BuildContext context,
) =>
    showDialog(
      barrierColor: Colors.green.withOpacity(0.24),
      //barrierDismissible: false,
      context: context,
      builder: (_) => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 155,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100]),
              padding: const EdgeInsets.fromLTRB(20, 20, 16, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          "Login Required to book appointment.",
                          style: kStyleShowDialog.copyWith(
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Do you want to go to login page?",
                        style: kStyleShowDialog.copyWith(
                            fontWeight: FontWeight.w300, fontSize: 12.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginPage();
                          }));
                        },
                        child: Text(
                          "Yes",
                          style: kStyleShowDialog.copyWith(fontSize: 12.sp),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "No",
                          style: kStyleShowDialog.copyWith(fontSize: 12.sp),
                        ),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );

// For Rate Us page
Future<void> showFeedbackDialog(BuildContext context) => showDialog(
      barrierColor: Colors.green.withOpacity(0.24),
      //barrierDismissible: false,
      context: context,
      builder: (_) => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height * 0.29,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              padding: const EdgeInsets.fromLTRB(20, 20, 16, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How would you rate your experience with Your Wellbeing?",
                        style: kStyleShowDialog.copyWith(
                            fontSize: 13.sp, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.sp),
                  Center(
                    child: RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      onRatingUpdate: (rating) async {
                        print(rating);
                      },
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showReviewSubmittedDialog(context);
                      },
                      child: Text(
                        'Rate',
                        style: TextStyle(color: Colors.green, fontSize: 13.sp),
                      ),
                    ),
                  ),
                  /*      SizedBox(height: 10.sp),*/
                ],
              ))
        ],
      ),
    );

//Review submitted showdialog
Future<void> showReviewSubmittedDialog(BuildContext context) => showDialog(
      barrierColor: Colors.green.withOpacity(0.24),
      //barrierDismissible: false,
      context: context,
      builder: (_) => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height * 0.29,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              padding: const EdgeInsets.fromLTRB(20, 20, 16, 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/reviewsubmitted.png',
                    height: 45,
                  ),
                  SizedBox(height: 10.sp),
                  Text(
                    "Review Submitted !",
                    style:
                        kStyleShowDialog.copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.sp),
                  Text(
                    'Thank you for your review',
                    style: kStyleShowDialog.copyWith(fontSize: 12.sp),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Ok',
                      style: TextStyle(color: Colors.green, fontSize: 13.sp),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
