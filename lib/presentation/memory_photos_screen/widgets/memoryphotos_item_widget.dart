import '../models/memoryphotos1_item_model.dart';
import '../models/memoryphotos_item_model.dart';
import '../widgets/memoryphotos1_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';

// ignore: must_be_immutable
class MemoryphotosItemWidget extends StatelessWidget {
  MemoryphotosItemWidget(
    this.memoryphotosItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  MemoryphotosItemModel memoryphotosItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 9.h,
            vertical: 2.v,
          ),
          decoration: AppDecoration.fillDeepPurple,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 4.v),
              Text(
                memoryphotosItemModelObj.dayText!,
                style: CustomTextStyles.titleLargeBlack900Bold,
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 135.v,
            crossAxisCount: 3,
            mainAxisSpacing: 0.h,
            crossAxisSpacing: 0.h,
          ),
          physics: NeverScrollableScrollPhysics(),
          itemCount:
              memoryphotosItemModelObj.memoryphotos1ItemList?.length ?? 0,
          itemBuilder: (context, index) {
            Memoryphotos1ItemModel model =
                memoryphotosItemModelObj.memoryphotos1ItemList?[index] ??
                    Memoryphotos1ItemModel();
            return Memoryphotos1ItemWidget(
              model,
            );
          },
        ),
      ],
    );
  }
}
