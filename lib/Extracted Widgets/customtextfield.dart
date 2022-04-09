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
    return Container(
      decoration: BoxDecoration(
        //For adding shadow in the back of text field
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                spreadRadius: 1,
                offset: Offset(0, 1),
                color: Color(0xff000000).withOpacity(0.1)),
          ]),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines ?? 1,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          // hintText: 'enter username',
          filled: true,
          fillColor: Colors.white, //To color the text field do these
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: textFieldDesignType == "top"
                ? const BorderRadius.only(
                topLeft: Radius.circular(6.0),
                topRight: Radius.circular(6.0))
                : textFieldDesignType == "bottom"
                ? BorderRadius.only(
                bottomLeft: Radius.circular(6.0),
                bottomRight: const Radius.circular(6.0))
                : textFieldDesignType == "both"
                ? BorderRadius.all(Radius.circular(6.0))
                : BorderRadius.all(const Radius.circular(0.0)),
          ),
        ),
      ),
    );
  }
}

//Text form field is the extracted widget from book appointment
class TextFormFieldForLoginRegister extends StatelessWidget {

  const TextFormFieldForLoginRegister(
      {this.label,
        this.imageName,
        this.textFieldDesignType,
        this.textFieldType,
        this.controller})
      : super();
  final String? label;
  final String? imageName;
  final String? textFieldDesignType;
  final String? textFieldType;
  final controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //For adding shadow in the back of text field
          boxShadow: [
            BoxShadow(
                blurRadius: 8,
                spreadRadius: 1,
                offset: Offset(0, 1),
                color: Color(0xff000000).withOpacity(0.1)),
          ]),
      child: TextFormField(
        controller: controller,
        keyboardType: textFieldType == "phone"
            ? TextInputType.number
            : TextInputType.text,
        cursorColor: Colors.black,
        obscureText: textFieldType == "password" ? true : false,
        decoration: InputDecoration(
          label: Text(
            label ?? 'Nothing to Show',
            style: TextStyle(
              fontFamily: 'NutinoSansReg',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff777777),
            ),
          ),
          // hintText: 'enter username',
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 26, right: 17),
            child: Image.asset(imageName ?? 'failed', width: 20),
          ),
          filled: true,
          fillColor: Colors.white, //To color the text field do these
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: textFieldDesignType == "top"
                ? const BorderRadius.only(
                topLeft: Radius.circular(6.0),
                topRight: Radius.circular(6.0))
                : textFieldDesignType == "bottom"
                ? BorderRadius.only(
                bottomLeft: Radius.circular(6.0),
                bottomRight: const Radius.circular(6.0))
                : textFieldDesignType == "both"
                ? BorderRadius.all(Radius.circular(6.0))
                : BorderRadius.all(Radius.circular(0.0)),
          ),
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
          //For adding shadow in the back of text field
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: Offset(0, 1),
                  color: Color(0xff000000).withOpacity(0.1)),
            ]),
        child: TextFormField(
          controller: controller,
          enabled: false,
          decoration: InputDecoration(
            label: Text(
              date ?? 'Nothing to Show',
              style: TextStyle(
                fontFamily: 'NutinoSansReg',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff777777),
              ),
            ),
            // hintText: 'enter username',
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 26, right: 17),
              child: Image.asset(imageName ?? 'failed', width: 20),
            ),
            filled: true,
            fillColor: Colors.white,
            //To color the text field do these
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: textFieldDesignType == "top"
                  ? const BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  topRight: Radius.circular(6.0))
                  : textFieldDesignType == "bottom"
                  ? BorderRadius.only(
                  bottomLeft: Radius.circular(6.0),
                  bottomRight: const Radius.circular(6.0))
                  : textFieldDesignType == "both"
                  ? BorderRadius.all(Radius.circular(6.0))
                  : BorderRadius.all(Radius.circular(0.0)),
            ),
          ),
        ),
      ),
    );
  }
}
