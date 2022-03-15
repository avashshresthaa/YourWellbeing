import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';

class LoginButton extends StatelessWidget {
  LoginButton(this.text, this.onPress);

  final text;
  final onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'NutinoSansReg',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

class PNButton extends StatelessWidget {
  PNButton({this.text, this.onPress, this.color});

  final text;
  final onPress;
  final color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'NutinoSansReg',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

class ArrowButton extends StatelessWidget {
  const ArrowButton(
      {required this.text,
      required this.color,
      required this.onPress,
      required this.arrow});

  final text;
  final color;
  final onPress;
  final arrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        boxShadow: [
          boxShadow,
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text,
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  arrow,
                  width: 24,
                ),
              ],
            )
          ],
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)))),
      ),
    );
  }
}

class LangButton extends StatelessWidget {
  LangButton(
    this.onPress,
    this.label,
  );

  final onPress;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 1.0, // soften the shadow
              offset: const Offset(
                1.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey,
            width: 0.9,
          ),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: kStyleHomeTitle,
          ),
        )),
      ),
    );
  }
}
