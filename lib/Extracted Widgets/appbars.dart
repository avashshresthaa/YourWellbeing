import 'package:flutter/material.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  MainAppBar(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: kStyleAppBar,
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}

class ProfileAppBar extends StatelessWidget with PreferredSizeWidget {
  ProfileAppBar({required this.title});
  final title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/backicon.png',
            width: 11.43,
            height: 20,
            color: Colors.green,
          ),
        ),
      ),
      title: Text(
        title,
        style: kStyleAppBar,
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}

class SChatAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final onTap;

  SChatAppBar({required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: kStyleAppBar,
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              "assets/list.png",
              color: Colors.green,
              width: 24,
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}

class AppointmentAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool tap;

  AppointmentAppBar({required this.title, required this.tap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: tap == true
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/backicon.png',
                  width: 11.43,
                  height: 20,
                  color: kStyleBlue,
                ),
              ),
            )
          : Container(),
      title: Text(
        title,
        style: kStyleAppBar.copyWith(color: kStyleBlue),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}
