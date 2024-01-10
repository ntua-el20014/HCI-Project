import '../home_list_screen/widgets/homelist_item_widget.dart';
import 'bloc/home_list_bloc.dart';
import 'models/home_list_model.dart';
import 'models/homelist_item_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/widgets/custom_floating_button.dart';
import 'package:anamnesis/widgets/custom_search_view.dart';
import 'package:anamnesis/widgets/custom_text_form_field.dart';

class HomeListScreen extends StatelessWidget {
  const HomeListScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<HomeListBloc>(
        create: (context) =>
            HomeListBloc(HomeListState(homeListModelObj: HomeListModel()))
              ..add(HomeListInitialEvent()),
        child: HomeListScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: double.maxFinite,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  _buildSearchPanel(context),
                  SizedBox(height: 3.v),
                  _buildHomeList(context)
                ])),
            floatingActionButton: _buildFloatingActionButton(context)));
  }

  /// Section Widget
  Widget _buildSearchPanel(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5.v),
        decoration: AppDecoration.outlineBlack,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocSelector<HomeListBloc, HomeListState, TextEditingController?>(
                  selector: (state) => state.searchController,
                  builder: (context, searchController) {
                    return CustomSearchView(
                        controller: searchController,
                        hintText: "lbl_find_a_memory".tr);
                  }),
              SizedBox(height: 8.v),
              SizedBox(
                  width: double.maxFinite,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocSelector<HomeListBloc, HomeListState,
                                TextEditingController?>(
                            selector: (state) => state.tagController,
                            builder: (context, tagController) {
                              return CustomTextFormField(
                                  width: 90.h,
                                  controller: tagController,
                                  hintText: "lbl_tag".tr,
                                  textInputAction: TextInputAction.done,
                                  prefix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          16.h, 11.v, 8.h, 11.v),
                                      child: CustomImageView(
                                          imagePath: ImageConstant.imgUser,
                                          height: 18.adaptSize,
                                          width: 18.adaptSize)),
                                  prefixConstraints:
                                      BoxConstraints(maxHeight: 40.v),
                                  suffix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          30.h, 11.v, 0, 11.v),
                                      child: CustomImageView(
                                          imagePath: ImageConstant.imgContrast,
                                          height: 18.adaptSize,
                                          width: 18.adaptSize)),
                                  suffixConstraints:
                                      BoxConstraints(maxHeight: 40.v));
                            }),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.h, vertical: 11.v),
                            decoration: AppDecoration.fillDeeppurple5002
                                .copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder19),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusStyle.circleBorder9),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomImageView(
                                          imagePath: ImageConstant.imgCalendar,
                                          height: 18.adaptSize,
                                          width: 18.adaptSize),
                                      Padding(
                                          padding: EdgeInsets.only(left: 8.h),
                                          child: Text("lbl_date".tr,
                                              style: CustomTextStyles
                                                  .titleSmall_1))
                                    ]))),
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 10.v),
                            decoration: AppDecoration.fillDeeppurple5002
                                .copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder19),
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(left: 16.h),
                                child: IntrinsicWidth(
                                    child: Container(
                                        width: 104.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder12),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomImageView(
                                                  imagePath:
                                                      ImageConstant.imgClock,
                                                  height: 18.adaptSize,
                                                  width: 18.adaptSize),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.h),
                                                  child: Text("lbl_duration".tr,
                                                      style: CustomTextStyles
                                                          .titleSmall_1)),
                                              Spacer(),
                                              Text("lbl_people".tr,
                                                  textAlign: TextAlign.center,
                                                  style: CustomTextStyles
                                                      .titleSmall_1)
                                            ]))))),
                        Container(
                            height: 40.v,
                            width: 25.h,
                            decoration: BoxDecoration(
                                color: appTheme.deepPurple5002,
                                borderRadius: BorderRadius.circular(12.h)))
                      ])),
              SizedBox(height: 3.v)
            ]));
  }

  /// Section Widget
  Widget _buildHomeList(BuildContext context) {
    return Expanded(
        child: BlocSelector<HomeListBloc, HomeListState, HomeListModel?>(
            selector: (state) => state.homeListModelObj,
            builder: (context, homeListModelObj) {
              return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 2.v);
                  },
                  itemCount: homeListModelObj?.homelistItemList.length ?? 0,
                  itemBuilder: (context, index) {
                    HomelistItemModel model =
                        homeListModelObj?.homelistItemList[index] ??
                            HomelistItemModel();
                    return HomelistItemWidget(model, onTapListItemListItem: () {
                      onTapListItemListItem(context);
                    });
                  });
            }));
  }

  /// Section Widget
  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingButton(
        height: 56,
        width: 56,
        backgroundColor: appTheme.deepPurple5001,
        child: CustomImageView(
          imagePath: ImageConstant.imgPlus,
          height: 28.0.v,
          width: 28.0.h,
          color: Colors.black),
      onTap: () {
        NavigatorService.pushNamed(
          AppRoutes.createMemoryScreen,
        );
      },
    );
  }

  /// Navigates to the memoryScreen when the action is triggered.
  onTapListItemListItem(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.memoryScreen,
    );
  }
}
