import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:yourwellbeing/Change%20Notifier/changenotifier.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Extracted Widgets/buttons.dart';

class SelectLanguage extends StatefulWidget {
  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  bool lang = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStyleBackgroundColor,
      appBar: ProfileAppBar(title: 'Select Language'),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
                  child: Text(
                    lang ? 'Welcome, User' : 'स्वागत छ',
                    //style: kStyleTime,
                  ),
                ),
                Text(
                  lang
                      ? 'Which language do you prefer\nfor this app?'
                      : 'तपाईं कुन भाषा प्रयोग गर्न चाहनु हुन्छ?',
                  // style: kStyleCheckedIn,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 128,
                ),
                Text(
                  'Select Language\nभाषा छनोट गर्नुहोस्',
                  //style: kStyleSelect,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                  child: LangButton(
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
                ),
                LangButton(() async {
                  setState(() {
                    lang = !lang;
                  });
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('languageData', false);
                  context.read<DataProvider>().changeString(false);
                  Navigator.pop(context);
                }, 'नेपाली'),
                Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: Text(
                    lang
                        ? 'You can change the language later\nfrom the settings menu.'
                        : ' हजुरले सेटिङ्बाट भाषा \n परिवर्तन गर्न सक्नुहुन्छ।',
                    /*                  style: kStyleSelect.copyWith(
                        fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,*/
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
