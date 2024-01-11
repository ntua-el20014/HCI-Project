import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/presentation/side_menu_screen/side_menu_screen.dart';

// ignore: must_be_immutable
class AppbarLeadingImage extends StatelessWidget {
  AppbarLeadingImage({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
    this.color,
  }) : super(
          key: key,
        );

  String? imagePath;

  Color? color;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              child: SideMenuScreen(),
            );
          },
        );
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          color: color,
          imagePath: imagePath,
          height: 24.adaptSize,
          width: 24.adaptSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
