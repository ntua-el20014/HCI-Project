import '../models/memoryjournals_item_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';

// ignore: must_be_immutable
class MemoryjournalsItemWidget extends StatelessWidget {
  MemoryjournalsItemWidget(
    this.memoryjournalsItemModelObj, {
    Key? key,
    this.onTapImgDynamicImage1,
  }) : super(
          key: key,
        );

  MemoryjournalsItemModel memoryjournalsItemModelObj;

  VoidCallback? onTapImgDynamicImage1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 10.h,
            vertical: 4.v,
          ),
          decoration: AppDecoration.fillDeepPurple,
          child: Text(
            memoryjournalsItemModelObj.dynamicText!,
            style: CustomTextStyles.titleLargeBlack900Bold,
          ),
        ),
        SizedBox(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgJournal1,
                height: 202.v,
                width: 180.h,
                onTap: () {
                  onTapImgDynamicImage1!.call();
                },
              ),
              CustomImageView(
                imagePath: ImageConstant.imgJournal2,
                height: 202.v,
                width: 180.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
