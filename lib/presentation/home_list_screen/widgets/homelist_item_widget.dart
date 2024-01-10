import '../models/homelist_item_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class HomelistItemWidget extends StatelessWidget {
  HomelistItemWidget(
    this.homelistItemModelObj, {
    Key? key,
    this.onTapListItemListItem,
  }) : super(
          key: key,
        );

  HomelistItemModel homelistItemModelObj;

  VoidCallback? onTapListItemListItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapListItemListItem!.call();
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(12.h),
        decoration: AppDecoration.fillGray,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: homelistItemModelObj.date,
              height: 56.adaptSize,
              width: 56.adaptSize,
              margin: EdgeInsets.only(bottom: 24.v),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.v),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                homelistItemModelObj.overlineText!,
                                style: theme.textTheme.labelLarge,
                              ),
                              SizedBox(height: 2.v),
                              Text(
                                homelistItemModelObj.headlineText!,
                                style: theme.textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 248.h,
                      margin: EdgeInsets.only(right: 12.h),
                      child: Text(
                        homelistItemModelObj.supportingText!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          height: 1.43,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
