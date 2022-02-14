import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Change%20Notifier/changenotifier.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Extracted Widgets/buttons.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  bool lang = true;

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
                  setState(() {
                    lang = !lang;
                  });
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('languageData', true);
                  context.read<DataProvider>().changeString(true);
                  Navigator.pop(context);
                },
                'English',
              ),
              const SizedBox(
                height: 16,
              ),
              LangButton(() async {
                setState(() {
                  lang = !lang;
                });
                //SharedPreferences used for saving the data in the local cache
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('languageData', false);

                //Provider package used to read and hold the data
                context.read<DataProvider>().changeString(false);
                Navigator.pop(context);
              }, 'नेपाली'),
            ],
          ),
        ],
      ),
    );
  }
}
