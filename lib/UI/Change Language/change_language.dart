import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Utils/user_prefrences.dart';
import '../../Extracted Widgets/buttons.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  var lang;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    lang = UserSimplePreferences.getLanguage() ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ProfileAppBar(title: 'Change Language'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            lang ? 'Pick Your Language' : 'स्वागत छ',
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
                () async {
                  /*               setState(() {
                    lang = !lang;
                  });*/
                  UserSimplePreferences.setLanguage(true);
                  Navigator.pop(context);
                },
                'English',
              ),
              const SizedBox(
                height: 16,
              ),
              LangButton(() async {
/*                setState(() {
                  lang = !lang;
                });*/
                //SharedPreferences used for saving the data in the local cache
                UserSimplePreferences.setLanguage(false);
                Navigator.pop(context);
              }, 'नेपाली'),
            ],
          ),
        ],
      ),
    );
  }
}
