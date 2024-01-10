import 'bloc/memory_photos_photo_bloc.dart';
import 'models/memory_photos_photo_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/widgets/app_bar/appbar_leading_image.dart';
import 'package:anamnesis/widgets/app_bar/appbar_subtitle.dart';
import 'package:anamnesis/widgets/app_bar/appbar_trailing_image.dart';
import 'package:anamnesis/widgets/app_bar/custom_app_bar.dart';

class MemoryPhotosPhotoScreen extends StatelessWidget {
  const MemoryPhotosPhotoScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<MemoryPhotosPhotoBloc>(
      create: (context) => MemoryPhotosPhotoBloc(MemoryPhotosPhotoState(
        memoryPhotosPhotoModelObj: MemoryPhotosPhotoModel(),
      ))
        ..add(MemoryPhotosPhotoInitialEvent()),
      child: MemoryPhotosPhotoScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoryPhotosPhotoBloc, MemoryPhotosPhotoState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: appTheme.black900,
            appBar: _buildAppBar(context),
            body: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  Spacer(
                    flex: 50,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgImg20231007141500230x360,
                    height: 230.v,
                    width: 360.h,
                  ),
                  Spacer(
                    flex: 50,
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
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgMegaphone,
        margin: EdgeInsets.only(
          left: 16.h,
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
          imagePath: ImageConstant.imgClose,
          margin: EdgeInsets.symmetric(
            horizontal: 14.h,
            vertical: 12.v,
          ),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }
}
