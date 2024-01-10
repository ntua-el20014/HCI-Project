import 'bloc/memory_map_bloc.dart';
import 'models/memory_map_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/widgets/app_bar/appbar_leading_image.dart';
import 'package:anamnesis/widgets/app_bar/appbar_subtitle.dart';
import 'package:anamnesis/widgets/app_bar/appbar_trailing_image.dart';
import 'package:anamnesis/widgets/app_bar/custom_app_bar.dart';

class MemoryMapScreen extends StatelessWidget {
  const MemoryMapScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<MemoryMapBloc>(
      create: (context) => MemoryMapBloc(MemoryMapState(
        memoryMapModelObj: MemoryMapModel(),
      ))
        ..add(MemoryMapInitialEvent()),
      child: MemoryMapScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoryMapBloc, MemoryMapState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
              height: 752.v,
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 62.h,
                bottom: 230.v,
              ),
              decoration: AppDecoration.fillWhiteA.copyWith(
                image: DecorationImage(
                  image: AssetImage(
                    ImageConstant.imgGroup90,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgYourJourney,
                    height: 63.v,
                    width: 153.h,
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(left: 35.h),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgCloseGray700,
                    height: 70.adaptSize,
                    width: 70.adaptSize,
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(bottom: 31.v),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 39.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgMegaphone,
        margin: EdgeInsets.only(
          left: 15.h,
          top: 12.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "lbl_memory_title".tr,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgArrowLeft,
          margin: EdgeInsets.symmetric(
            horizontal: 15.h,
            vertical: 12.v,
          ),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }
}
