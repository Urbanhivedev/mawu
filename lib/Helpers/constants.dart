import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'colors.dart';

Widget horizontalSpacer(double width) {
  return SizedBox(
    width: width,
  );
}

Widget verticalSpacer(double height) {
  return SizedBox(
    height: height,
  );
}

PreferredSizeWidget ChatAppar(
  BuildContext context,
  String appBarTitle,
  String imageUrl,
) {
  return AppBar(
    actions: [horizontalSpacer(10)],
    iconTheme: const IconThemeData(color: Colors.black, size: 30),
    backgroundColor: orange,
    elevation: 5,
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        CustomSubTitleText(
          color: const Color(0xFF2B2E4A),
          title: appBarTitle.toUpperCase(),
          size: 18,
        ),
      ],
    ),
  );
}

class CustomSubTitleText extends StatelessWidget {
  final String title;
  final double size;
  final Color? color;
  final bool align;
  FontWeight? fontWeight;
  CustomSubTitleText({
    required this.title,
    required this.color,
    this.size = 21,
    this.align = false,
    this.fontWeight = FontWeight.bold,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: align
          ? Align(
              alignment: Alignment.centerLeft,
              child: Text(title,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: size, fontWeight: fontWeight, color: color)))
          : Align(
              //alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: size, fontWeight: fontWeight, color: color),
              ),
            ),
    );
  }
}

FormBuilderTextField customMessageField(
  String name,
  IconData prefixIcon,
  IconData? suffixIcon,
  String labelText, {
  String? hintText,
  Widget? prefix,
  String? initialValue,
  bool isHint = false,
  bool obscureText = false,
  String? helperText,
  String? Function(String?)? validator,
}) {
  return FormBuilderTextField(
    style: TextStyle(color: white),
    initialValue: initialValue,
    cursorColor: orange,
    name: name,
    obscureText: obscureText,
    validator: validator,
    decoration: customMessageDecoration(
        hintText, labelText, prefixIcon, suffixIcon,
        prefix: prefix, helperText: helperText),
  );
}

InputDecoration customMessageDecoration(String? hintText, String labelText,
    IconData? prefixIcon, IconData? suffixIcon,
    {String? helperText, Widget? prefix, bool isHint = false}) {
  return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: isHint ? '' : hintText,
      prefix: prefix,
      helperText: helperText,
      helperMaxLines: 7,
      helperStyle: const TextStyle(fontSize: 13),
      floatingLabelStyle: TextStyle(color: orange),
      fillColor: Yellow,
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Yellow)),
      prefixIcon: Icon(
        prefixIcon,
        size: 20,
      ),
      labelText: labelText,
      labelStyle:
          TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: orange));
}

Widget loader({double size = 50}) {
  return SpinKitWave(
    color: orange,
    size: size,
  );
}

PreferredSizeWidget MessageAppar(
  BuildContext context,
  String appBarTitle,
  String imageUrl,
) {
  return AppBar(
      actions: [
        CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        horizontalSpacer(10)
      ],
      iconTheme: IconThemeData(color: orange, size: 30),
      backgroundColor: Colors.transparent,
      elevation: 0,
      //centerTitle: true,
      title: SubTitleText1(
        title: appBarTitle,
        size: 23,
      )
      // Text(
      //   appBarTitle,
      //   style:
      //       Theme.of(context).textTheme.headline2!.copyWith(color: Colors.black),
      // ),
      );
}

class SubTitleText extends StatelessWidget {
  final String title;
  final double size;
  FontWeight? fontWeight;
  SubTitleText({
    required this.title,
    this.size = 21,
    this.fontWeight = FontWeight.w900,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: size, fontWeight: fontWeight),
            )));
  }
}

class SubTitleText1 extends StatelessWidget {
  final String title;
  final double size;
  FontWeight? fontWeight;
  SubTitleText1({
    required this.title,
    this.size = 21,
    this.fontWeight = FontWeight.w900,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: size, fontWeight: fontWeight, color: orange),
            )));
  }
}

FormBuilderTextField customFormBuilderTextField(
  String name,
  IconData prefixIcon,
  IconData? suffixIcon,
  String labelText, {
  String? hintText,
  Widget? prefix,
  String? initialValue,
  bool isHint = false,
  bool obscureText = false,
  String? helperText,
  String? Function(String?)? validator,
}) {
  return FormBuilderTextField(
    initialValue: initialValue,
    cursorColor: Yellow,
    name: name,
    obscureText: obscureText,
    validator: validator,
    decoration: customFormDecoration(
        hintText, labelText, prefixIcon, suffixIcon,
        prefix: prefix, helperText: helperText),
  );
}

InputDecoration customFormDecoration(String? hintText, String labelText,
    IconData? prefixIcon, IconData? suffixIcon,
    {String? helperText, Widget? prefix, bool isHint = false}) {
  return InputDecoration(
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: orange)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: orange)),
      hintText: isHint ? '' : hintText,
      prefix: prefix,
      helperText: helperText,
      helperMaxLines: 7,
      helperStyle: const TextStyle(fontSize: 13),
      floatingLabelStyle: TextStyle(color: Yellow),

      // fillColor: Yellow,
      // focusedBorder:
      //     UnderlineInputBorder(borderSide: BorderSide(color: Yellow)),
      prefixIcon: Icon(
        prefixIcon,
        size: 20,
      ),
      suffixIcon: Icon(
        suffixIcon,
        size: 20,
      ),
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
}
