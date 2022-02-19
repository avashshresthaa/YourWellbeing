import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

//Colors

const kStyleMainGrey = Color(0xFF8A8C8F);
const kStyleCoolGrey = Color(0xFF252627);
const kStyleBackgroundColor = Color(0xffF1F7FA);
const kStyleGrey333 = Color(0xff333333);

var kStyleTextField = TextStyle(
  fontFamily: 'NutinoSansReg',
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  color: const Color(0xff777777),
);

const kBorder = BorderSide(
  width: 1,
  color: Colors.green,
);

const kErrorBorder = BorderSide(
  width: 1,
  color: Colors.red,
);

var kStyleHomeTitle = TextStyle(
  fontFamily: 'NutinoSansReg',
  fontSize: 12.sp,
  fontWeight: FontWeight.w600,
  color: kStyleCoolGrey,
);

var boxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.5),
  blurRadius: 2.0, // soften the shadow
  offset: const Offset(
    0.0, // Move to right 10  horizontally
    2.0, // Move to bottom 10 Vertically
  ),
);

BorderRadius kBorderRadius = BorderRadius.circular(8.0);

var kStyleShowDialog = TextStyle(
  fontSize: 14.sp,
  fontFamily: 'NutinoSansReg',
  letterSpacing: 0.4,
  color: kStyleCoolGrey,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.none,
);

var kStyleAppBar = TextStyle(
  fontFamily: 'NutinoSansReg',
  fontSize: 13.sp,
  fontWeight: FontWeight.w600,
  color: Colors.green,
);

var kStyleButtonContent = TextStyle(
  fontFamily: 'NutinoSansReg',
  fontSize: 12.sp,
  color: Color(0xff444647),
  fontWeight: FontWeight.w300,
);
