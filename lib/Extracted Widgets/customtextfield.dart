import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
