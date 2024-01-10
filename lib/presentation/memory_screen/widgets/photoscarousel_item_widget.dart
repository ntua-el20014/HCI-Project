import '../models/photoscarousel_item_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';

// ignore: must_be_immutable
class PhotoscarouselItemWidget extends StatelessWidget {
  PhotoscarouselItemWidget(
    this.photoscarouselItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  PhotoscarouselItemModel photoscarouselItemModelObj;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210.h,
      child: CustomImageView(
        imagePath: photoscarouselItemModelObj.carouselItem,
        height: 172.v,
        width: 210.h,
        radius: BorderRadius.circular(
          28.h,
        ),
        margin: EdgeInsets.only(left: 14.h),
      ),
    );
  }
}
