import 'bloc/create_memory_bloc.dart';
import 'models/create_memory_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/widgets/app_bar/appbar_leading_image.dart';
import 'package:anamnesis/widgets/app_bar/appbar_subtitle.dart';
import 'package:anamnesis/widgets/app_bar/appbar_trailing_image.dart';
import 'package:anamnesis/widgets/app_bar/custom_app_bar.dart';
import 'package:anamnesis/widgets/custom_drop_down.dart';
import 'package:anamnesis/widgets/custom_elevated_button.dart';
import 'package:anamnesis/widgets/custom_floating_text_field.dart';
import 'package:anamnesis/widgets/custom_icon_button.dart';

class CreateMemoryScreen extends StatelessWidget {
  const CreateMemoryScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<CreateMemoryBloc>(
      create: (context) => CreateMemoryBloc(CreateMemoryState(
        createMemoryModelObj: CreateMemoryModel(),
      ))
        ..add(CreateMemoryInitialEvent()),
      child: CreateMemoryScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 10.h,
            vertical: 7.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle1(context),
              SizedBox(height: 8.v),
              _buildInputDatePicker(context),
              SizedBox(height: 17.v),
              _buildLocation(context),
              SizedBox(height: 9.v),
              _buildAddPeople(context),
              SizedBox(height: 29.v),
              _buildSelectTags(context),
              SizedBox(height: 5.v),
            ],
          ),
        ),
        bottomNavigationBar: _buildPhotos(context),
      ),
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
        text: "lbl_new_memory".tr,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgNotification,
          margin: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 12.v,
          ),
        ),
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildTitle(BuildContext context) {
    return BlocSelector<CreateMemoryBloc, CreateMemoryState,
        TextEditingController?>(
      selector: (state) => state.titleController,
      builder: (context, titleController) {
        return CustomFloatingTextField(
          controller: titleController,
          labelText: "lbl_title".tr,
          labelStyle: CustomTextStyles.titleLarge20_1,
          hintText: "lbl_title".tr,
          suffix: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgIcon,
              height: 20.adaptSize,
              width: 20.adaptSize,
            ),
          ),
          suffixConstraints: BoxConstraints(
            maxHeight: 67.v,
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildTitle1(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.customBorderTL4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          SizedBox(height: 4.v),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "msg_add_a_title_to_your".tr,
              style: CustomTextStyles.bodyMedium_1,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDate(BuildContext context) {
    return BlocSelector<CreateMemoryBloc, CreateMemoryState,
        TextEditingController?>(
      selector: (state) => state.dateController,
      builder: (context, dateController) {
        return CustomFloatingTextField(
          controller: dateController,
          labelText: "lbl_enter_dates".tr,
          labelStyle: CustomTextStyles.titleLarge20,
          hintText: "lbl_enter_dates".tr,
          hintStyle: CustomTextStyles.titleLarge20,
          suffix: Container(
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgIconsToday24px,
              height: 24.adaptSize,
              width: 24.adaptSize,
            ),
          ),
          suffixConstraints: BoxConstraints(
            maxHeight: 72.v,
          ),
          contentPadding: EdgeInsets.fromLTRB(24.h, 27.v, 24.h, 20.v),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildDate1(BuildContext context) {
    return BlocSelector<CreateMemoryBloc, CreateMemoryState,
        TextEditingController?>(
      selector: (state) => state.dateController1,
      builder: (context, dateController1) {
        return CustomFloatingTextField(
          width: 137.h,
          controller: dateController1,
          labelText: "lbl_date".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "lbl_date".tr,
          hintStyle: theme.textTheme.bodyLarge!,
          contentPadding: EdgeInsets.fromLTRB(16.h, 19.v, 16.h, 17.v),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildDate2(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12.h,
        top: 8.v,
      ),
      child: BlocSelector<CreateMemoryBloc, CreateMemoryState,
          TextEditingController?>(
        selector: (state) => state.dateController2,
        builder: (context, dateController2) {
          return CustomFloatingTextField(
            width: 137.h,
            controller: dateController2,
            labelText: "lbl_end_date".tr,
            labelStyle: CustomTextStyles.bodyLargeGray800_1,
            hintText: "lbl_end_date".tr,
            contentPadding: EdgeInsets.fromLTRB(16.h, 17.v, 16.h, 19.v),
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildInputDatePicker(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder28,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDate(context),
          SizedBox(height: 9.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDate1(context),
                _buildDate2(context),
              ],
            ),
          ),
          SizedBox(height: 9.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLocation(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.customBorderTL4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocSelector<CreateMemoryBloc, CreateMemoryState,
              TextEditingController?>(
            selector: (state) => state.locationController,
            builder: (context, locationController) {
              return CustomFloatingTextField(
                controller: locationController,
                labelText: "lbl_location".tr,
                labelStyle: CustomTextStyles.titleLarge20_1,
                hintText: "lbl_location".tr,
                textInputAction: TextInputAction.done,
                suffix: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgContrastDeepPurple500,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                  ),
                ),
                suffixConstraints: BoxConstraints(
                  maxHeight: 68.v,
                ),
              );
            },
          ),
          SizedBox(height: 4.v),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "msg_search_or_pick_your".tr,
              style: CustomTextStyles.bodyMedium_1,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAddPeople(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "lbl_add_people".tr,
          style: CustomTextStyles.titleLargeBlack900,
        ),
        SizedBox(height: 13.v),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 7.v,
          ),
          decoration: AppDecoration.fillGray,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgLock,
                height: 24.adaptSize,
                width: 24.adaptSize,
                margin: EdgeInsets.only(bottom: 1.v),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.h,
                  bottom: 4.v,
                ),
                child: Text(
                  "lbl_person_1".tr,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              Spacer(),
              Container(
                height: 24.adaptSize,
                width: 24.adaptSize,
                margin: EdgeInsets.only(bottom: 1.v),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 18.adaptSize,
                        width: 18.adaptSize,
                        decoration: BoxDecoration(
                          color: appTheme.deepPurple500,
                          borderRadius: BorderRadius.circular(
                            2.h,
                          ),
                        ),
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgIconsCheckSmall,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 7.v,
          ),
          decoration: AppDecoration.fillGray,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgLock,
                height: 24.adaptSize,
                width: 24.adaptSize,
                margin: EdgeInsets.only(bottom: 1.v),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.h,
                  bottom: 4.v,
                ),
                child: Text(
                  "lbl_person_2".tr,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              Spacer(),
              Container(
                height: 24.adaptSize,
                width: 24.adaptSize,
                margin: EdgeInsets.only(bottom: 1.v),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 18.adaptSize,
                        width: 18.adaptSize,
                        decoration: BoxDecoration(
                          color: appTheme.deepPurple500,
                          borderRadius: BorderRadius.circular(
                            2.h,
                          ),
                        ),
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgIconsCheckSmall,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
        SizedBox(height: 3.v),
        SizedBox(
          height: 65.v,
          width: 334.h,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 55.v,
                  width: 334.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4.h,
                    ),
                    border: Border.all(
                      color: appTheme.gray600,
                      width: 1.h,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 12.h,
                    right: 12.h,
                    bottom: 13.v,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24.v,
                            width: 152.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 16.v,
                                    width: 152.h,
                                    margin: EdgeInsets.only(top: 2.v),
                                    decoration: BoxDecoration(
                                      color: appTheme.gray50,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "lbl_add_new_person".tr,
                                    style: CustomTextStyles.titleLargeGray80020,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.v),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Text(
                              "lbl_new_person".tr,
                              style: CustomTextStyles.titleLarge20_1,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 26.v),
                        child: CustomIconButton(
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          padding: EdgeInsets.all(2.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgIcon,
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
      ],
    );
  }

  /// Section Widget
  Widget _buildSelectTags(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 65.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_select_tags".tr,
            style: CustomTextStyles.titleLargeBlack900,
          ),
          SizedBox(height: 14.v),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.v),
                child: BlocSelector<CreateMemoryBloc, CreateMemoryState,
                    CreateMemoryModel?>(
                  selector: (state) => state.createMemoryModelObj,
                  builder: (context, createMemoryModelObj) {
                    return CustomDropDown(
                      width: 103.h,
                      icon: Container(
                        margin: EdgeInsets.fromLTRB(9.h, 7.v, 8.h, 7.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgTrailingIcon,
                          height: 18.adaptSize,
                          width: 18.adaptSize,
                        ),
                      ),
                      hintText: "lbl_tag_1".tr,
                      items: createMemoryModelObj?.dropdownItemList ?? [],
                      prefix: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 8.h,
                          vertical: 7.v,
                        ),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgSelectedIcon,
                          height: 18.adaptSize,
                          width: 18.adaptSize,
                        ),
                      ),
                      prefixConstraints: BoxConstraints(
                        maxHeight: 32.v,
                      ),
                      onChanged: (value) {
                        context
                            .read<CreateMemoryBloc>()
                            .add(ChangeDropDownEvent(value: value));
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10.h,
                  top: 4.v,
                  bottom: 4.v,
                ),
                child: BlocSelector<CreateMemoryBloc, CreateMemoryState,
                    CreateMemoryModel?>(
                  selector: (state) => state.createMemoryModelObj,
                  builder: (context, createMemoryModelObj) {
                    return CustomDropDown(
                      width: 103.h,
                      icon: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 8.h,
                          vertical: 7.v,
                        ),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgTrailingIcon,
                          height: 18.adaptSize,
                          width: 18.adaptSize,
                        ),
                      ),
                      hintText: "lbl_tag_2".tr,
                      items: createMemoryModelObj?.dropdownItemList1 ?? [],
                      prefix: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 8.h,
                          vertical: 7.v,
                        ),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgSelectedIcon,
                          height: 18.adaptSize,
                          width: 18.adaptSize,
                        ),
                      ),
                      prefixConstraints: BoxConstraints(
                        maxHeight: 32.v,
                      ),
                      onChanged: (value) {
                        context
                            .read<CreateMemoryBloc>()
                            .add(ChangeDropDown1Event(value: value));
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.h),
                child: CustomIconButton(
                  height: 40.adaptSize,
                  width: 40.adaptSize,
                  padding: EdgeInsets.all(8.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgPlusGray900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAdd(BuildContext context) {
    return CustomElevatedButton(
      height: 35.v,
      width: 92.h,
      text: "lbl_add".tr,
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgPlus,
          height: 18.adaptSize,
          width: 18.adaptSize,
        ),
      ),
      buttonStyle: CustomButtonStyles.outlineBlackTL17,
      buttonTextStyle: CustomTextStyles.titleSmallDeeppurple500,
    );
  }

  /// Section Widget
  Widget _buildPhotos(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 9.v,
                  bottom: 1.v,
                ),
                child: Text(
                  "msg_photos_from_gallery".tr,
                  style: CustomTextStyles.titleLargeBlack900,
                ),
              ),
              _buildAdd(context),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              top: 18.v,
              right: 16.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgItem1,
                  height: 1.v,
                  width: 116.h,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgItem2,
                  height: 1.v,
                  width: 120.h,
                  margin: EdgeInsets.only(left: 8.h),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgItemLast,
                  height: 1.v,
                  width: 56.h,
                  margin: EdgeInsets.only(left: 8.h),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
