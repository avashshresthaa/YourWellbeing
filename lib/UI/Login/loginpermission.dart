import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Network/NetworkHelper.dart';
import 'package:yourwellbeing/UI/Login/login.dart';
import 'package:yourwellbeing/UI/Login/signup.dart';
import '../../Extracted Widgets/buttons.dart';

class SignUpContent extends StatefulWidget {
  const SignUpContent({Key? key}) : super(key: key);

  @override
  _SignUpContentState createState() => _SignUpContentState();
}

class _SignUpContentState extends State<SignUpContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: AspectRatio(
            aspectRatio: 12 / 4,
            child: Image.asset(
              'assets/logo.png',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0, bottom: 32),
          child: Text('Sign in to your account to',
              style: kStyleHomeTitle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: kStyleCoolGrey)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 81.0, bottom: 16),
          child: contentText(
            'Book your appointment',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 81.0, bottom: 16),
          child: contentText(
            'Chat with an health expert',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 81.0, bottom: 36),
          child: contentText(
            'View your appointment details',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: ArrowButton(
            text: Text(
              'Already a customer? Sign In',
              textAlign: TextAlign.center,
              style: kStyleButtonContent.copyWith(color: Colors.white),
            ),
            onPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }));
            },
            color: Colors.green,
            arrow: 'assets/whitebuttonarrow.png',
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: ArrowButton(
            text: Text(
              'New to Your Wellbeing? Sign up',
              textAlign: TextAlign.center,
              style: kStyleButtonContent.copyWith(color: Colors.black),
            ),
            onPress: () async {
              NetworkHelper network = NetworkHelper();
              await network.getContactsData();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SignupPage();
              }));
            },
            color: Colors.white,
            arrow: 'assets/forwardarrow.png',
          ),
        ),
      ],
    );
  }
}

Widget contentText(String text) {
  return Row(
    children: [
      SizedBox(height: 24, width: 24, child: Image.asset('assets/right.png')),
      Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(
          text,
          style: kStyleButtonContent.copyWith(fontWeight: FontWeight.w600),
        ),
      )
    ],
  );
}
