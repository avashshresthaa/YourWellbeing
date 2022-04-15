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

class TextFormFieldEmpty extends StatelessWidget {
  const TextFormFieldEmpty(
      {this.textFieldDesignType, this.maxLines, this.controller})
      : super();
  final String? textFieldDesignType;
  final maxLines;
  final controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white, //To color the text field do these
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: kBorder.copyWith(color: kStyleBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: kBorder.copyWith(color: Colors.grey.shade300),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: kBorder.copyWith(color: kStyleBlue),
        ),
      ),
    );
  }
}

//Text form field is the extracted widget from book appointment
class TextFormFieldForLoginRegister extends StatelessWidget {
  const TextFormFieldForLoginRegister({
    this.label,
    this.imageName,
    this.textFieldDesignType,
    this.textFieldType,
    this.controller,
  }) : super();
  final String? label;
  final imageName;
  final String? textFieldDesignType;
  final String? textFieldType;
  final controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType:
          textFieldType == "phone" ? TextInputType.number : TextInputType.text,
      cursorColor: Colors.black,
      obscureText: textFieldType == "password" ? true : false,
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 8),
          child: Icon(
            imageName,
            size: 20,
          ),
        ),
        filled: true,
        fillColor: Colors.white, //To color the text field do these
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: kBorder.copyWith(color: kStyleBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: kBorder.copyWith(color: Colors.grey.shade300),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: kBorder.copyWith(color: kStyleBlue),
        ),
      ),
    );
  }
}

class DatePickerField extends StatelessWidget {
  DatePickerField(
      {required this.controller,
      required this.date,
      required this.onPress,
      this.imageName,
      this.textFieldDesignType});

  final controller;
  final date;
  final onPress;
  final imageName;
  final textFieldDesignType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(
              Radius.circular(4.0) //                 <--- border radius here
              ),
        ),
        child: TextFormField(
          controller: controller,
          enabled: false,
          decoration: InputDecoration(
            hintText: date,
            // hintText: 'enter username',
            //To color the text field do these
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Icon(
                imageName,
                size: 20,
              ),
            ),
            filled: true,
            fillColor: Colors.white, //To color the text field do these
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: kBorder.copyWith(color: kStyleBlue),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: kBorder.copyWith(color: Colors.grey.shade300),
            ),
          ),
        ),
      ),
    );
  }
}
