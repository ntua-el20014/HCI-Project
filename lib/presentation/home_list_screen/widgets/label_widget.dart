import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class LabelWidget extends StatelessWidget {
  final String? imagePath;
  final String? labelText;
  final String? value; // Added value property

  LabelWidget(
      {this.imagePath,
      this.labelText,
      this.value}); // Added value to constructor

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 20
            .v, // Adjust this value to change the height of the carousel items
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 12.h, vertical: 1.v), // Reduced vertical padding
            decoration: AppDecoration.fillDeeppurple5002
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder19),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.circleBorder9),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  CustomImageView(
                      imagePath: imagePath ?? "",
                      height: 24.adaptSize,
                      width: 24.adaptSize),
                  Padding(
                      padding: EdgeInsets.only(left: 3.h),
                      child: Text(labelText ?? "",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400))),
                ]))));
  }
}
