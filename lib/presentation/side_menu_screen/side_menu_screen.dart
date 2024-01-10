import 'bloc/side_menu_bloc.dart';
import 'models/side_menu_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/widgets/app_bar/appbar_leading_image.dart';
import 'package:anamnesis/widgets/app_bar/appbar_title.dart';
import 'package:anamnesis/widgets/app_bar/custom_app_bar.dart';

class SideMenuScreen extends StatelessWidget {
  const SideMenuScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<SideMenuBloc>(
        create: (context) =>
            SideMenuBloc(SideMenuState(sideMenuModelObj: SideMenuModel()))
              ..add(SideMenuInitialEvent()),
        child: SideMenuScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SideMenuBloc, SideMenuState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              backgroundColor: appTheme.gray100,
              appBar: _buildAppBar(context),
              body: Container(
                  width: 234.h,
                  margin: EdgeInsets.only(top: 10.v, bottom: 5.v),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.h, vertical: 27.v),
                  decoration: AppDecoration.outlineBlack900
                      .copyWith(borderRadius: BorderRadiusStyle.roundedBorder4),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("lbl_my_memories".tr,
                            style: theme.textTheme.bodyLarge),
                        SizedBox(height: 36.v),
                        Text("lbl_people".tr, style: theme.textTheme.bodyLarge),
                        SizedBox(height: 35.v),
                        Text("lbl_drafts".tr, style: theme.textTheme.bodyLarge),
                        SizedBox(height: 38.v),
                        Text("msg_create_new_tag".tr,
                            style: theme.textTheme.bodyLarge),
                        SizedBox(height: 36.v),
                        Text("lbl_insights".tr,
                            style: theme.textTheme.bodyLarge),
                        SizedBox(height: 35.v),
                        Text("lbl_trash".tr, style: theme.textTheme.bodyLarge),
                        SizedBox(height: 38.v),
                        Text("lbl_settings".tr,
                            style: theme.textTheme.bodyLarge),
                        SizedBox(height: 35.v),
                        Text("lbl_about".tr, style: theme.textTheme.bodyLarge),
                        SizedBox(height: 5.v)
                      ]))));
    });
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 56.v,
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 16.h, top: 14.v, bottom: 17.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarTitle(
            text: "lbl_menu".tr, margin: EdgeInsets.only(left: 12.h)));
  }

  /// Navigates to the previous screen.
  onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }
}
