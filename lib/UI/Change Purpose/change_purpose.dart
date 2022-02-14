import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Change%20Notifier/changenotifier.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Extracted Widgets/buttons.dart';

class ChangePurpose extends StatefulWidget {
  @override
  _ChangePurposeState createState() => _ChangePurposeState();
}

class _ChangePurposeState extends State<ChangePurpose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ProfileAppBar(title: 'Change Purpose'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Select Your Purpose',
            style: kStyleHomeTitle.copyWith(
              fontSize: 18.sp,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            'Welcome, User',
            style: kStyleHomeTitle.copyWith(
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Please select your preferable language.',
            style: kStyleTextField.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            children: [
              LangButton(
                () async {},
                'Covid-19',
              ),
              const SizedBox(
                height: 16,
              ),
              LangButton(() async {}, 'Influenza'),
            ],
          ),
        ],
      ),
    );
  }
}
