import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      this.hintText, this.icon, this.nameController, this.validator,
      {Key? key})
      : super(key: key);

  final dynamic hintText;
  final IconData icon;
  final dynamic validator;
  final dynamic nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      validator: validator,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(
        fontFamily: 'NutinoSansReg',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xff777777),
      ),
      decoration: InputDecoration(
          fillColor: Colors.white,
          border: InputBorder.none,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: kBorder,
            borderRadius: kBorderRadius,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: kBorder,
            borderRadius: kBorderRadius,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: Colors.red,
            ),
            borderRadius: kBorderRadius,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: kBorder,
            borderRadius: kBorderRadius,
          ),
          hintText: hintText,
          hintStyle: kStyleTextField,
          contentPadding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 12),
            child: Icon(
              icon,
              size: 20,
            ),
          )),
    );
  }
}

class NotificationField extends StatelessWidget {
  NotificationField(
      {required this.onChanged,
      required this.hintText,
      required this.controller,
      required this.validator});

  final onChanged;
  final hintText;

  final dynamic controller;
  final dynamic validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(
        fontFamily: 'NutinoSansReg',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xff777777),
      ),
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: InputBorder.none,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: kBorder,
          borderRadius: kBorderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: kBorder,
          borderRadius: kBorderRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
          borderRadius: kBorderRadius,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: kBorder,
          borderRadius: kBorderRadius,
        ),
        hintText: hintText,
        hintStyle: kStyleTextField,
        contentPadding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      ),
    );
  }
}

class ChatField extends StatelessWidget {
  ChatField(
      {required this.hintText, required this.controller, required this.onTap});

  final onTap;
  final hintText;
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        controller: controller,
        autocorrect: false,
        keyboardType: TextInputType.visiblePassword,
        style: TextStyle(
          fontFamily: 'NutinoSansReg',
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xff777777),
        ),
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'assets/chatsend.png',
                width: 24,
              ),
            ),
          ),
          fillColor: Colors.white,
          border: InputBorder.none,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: kBorder,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: kBorder,
          ),
          hintText: hintText,
          hintStyle: kStyleTextField,
        ),
      ),
    );
  }
}
