import '../models/memoryphotos1_item_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';

// ignore: must_be_immutable
class Memoryphotos1ItemWidget extends StatelessWidget {
  Memoryphotos1ItemWidget(
    this.memoryphotos1ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Memoryphotos1ItemModel memoryphotos1ItemModelObj;

  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      imagePath: memoryphotos1ItemModelObj.image1,
      height: 134.v,
      width: 121.h,
    );
  }
}
