import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hieroglyphic_app/compenets/constant/colors.dart';

Widget socialloginscreen({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          // ignore: void_checks
          return function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

class DefalutTextFormField extends StatelessWidget {
  DefalutTextFormField(
      {super.key,
      required this.label,
      required this.controller,
      required this.prefix,
      required this.type,
      required String? Function(String? value) validate,
      this.suffix,
      this.isPassword = false,
      this.suffixPressed});
  TextEditingController controller;
  TextInputType type;
  Function? onSubmit;
  Function? onChange;
  Function? onTap;
  bool isPassword = false;
  Function? validate;
  String label;
  IconData prefix;
  IconData? suffix;
  Function? suffixPressed;
  bool isClickable = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s) {
        return onSubmit!(s);
      },
      onChanged: (s) {
        // ignore: void_checks
        return onChange!(s);
      },
      onTap: () {
        // ignore: void_checks
        return onTap!();
      },
      validator: (s) {
        return validate!(s);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  // ignore: void_checks
                  return suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s) {
        return onSubmit!(s);
      },
      onChanged: (s) {
        return onChange!(s);
      },
      onTap: () {
        return onTap!();
      },
      validator: (s) {
        return validate(s);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  return suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget textButton(
        {required String text,
        required Function function,
        double width = 200}) =>
    TextButton(
        style: ButtonStyle(


        ),
        onPressed: () {
          return function();
        },
        child: Text(text,style: TextStyle(color: AppColor.primaryColor),));
Widget defaultMaterialButton({
  required Function function,
  required String text,
  double height = 40.0,
  double width = double.infinity,
  double radius = 3.0,
  bool isUpperCase = true,
  Function? onTap,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: AppColor.primaryColor,
        //  color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
void ShowToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum  كذا اختيار من حاجة

// ignore: constant_identifier_names
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Widget,
        ), (route) {
      return false;
    });
void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text,
      ),
    );
