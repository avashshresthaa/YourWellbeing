import 'package:flutter/material.dart';
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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
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

class ArrowButton extends StatelessWidget {
  const ArrowButton(
      {required this.text,
      required this.color,
      this.onPress,
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
        borderRadius: BorderRadius.circular(24),
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
                  width: 28,
                ),
              ],
            )
          ],
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)))),
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
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 60),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey,
              width: 0.6,
            )),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            //style: kStyleSelect,
          ),
        )),
      ),
    );
  }
}
