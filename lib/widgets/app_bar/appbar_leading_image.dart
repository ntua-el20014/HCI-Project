import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';

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
        NavigatorService.pushNamed(
          AppRoutes.sideMenuScreen,
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
