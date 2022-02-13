import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

SnackBar customSnackBar(message, color, icon, bottomText) => SnackBar(
      content: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 25,
              color: Colors.white,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'NutinoSansBold',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      bottomText,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontFamily: 'NutinoSansReg',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: color,
      duration: Duration(seconds: 2),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
    );

void showSnackBar(BuildContext context, String message, Color color,
    IconData icon, String bottomText) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    customSnackBar(message, color, icon, bottomText),
  );
}
