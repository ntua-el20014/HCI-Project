import '../home_list_screen/widgets/homelist_item_widget.dart';
import 'widgets/permission_request.dart';
import 'bloc/home_list_bloc.dart';
import 'models/home_list_model.dart';
import 'models/homelist_item_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/widgets/custom_floating_button.dart';
import 'package:anamnesis/widgets/custom_search_view.dart';
//import 'package:anamnesis/widgets/custom_text_form_field.dart';
import 'models/label_item_model.dart';
import 'widgets/label_widget.dart';

final List<LabelItemModel> labels = [
  LabelItemModel(
      label: 'Tag', iconPath: ImageConstant.imgUser, value: 'lbl_tag'),
  LabelItemModel(
      label: 'Date', iconPath: ImageConstant.imgCalendar, value: 'lbl_date'),
  LabelItemModel(
      label: 'Duration',
      iconPath: ImageConstant.imgClock,
      value: 'lbl_duration'),
  LabelItemModel(
      label: 'People',
      iconPath: ImageConstant.imgContrast,
      value: 'lbl_people'),
];

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
    return PermissionRequest(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: _buildSearchPanel(context),
              ),
              Expanded(
                child: Stack(
                  children: [
                    _buildHomeList(context),
                    Align(
                      alignment: Alignment.topRight,
                      child: _buildFloatingMapButton(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: _buildFloatingActionButton(context),
        ),
      ),
    );
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
                        autofocus: false,
                        controller: searchController,
                        hintText: "lbl_find_a_memory".tr);
                  }),
              SizedBox(
                width: double.maxFinite,
                child: _buildLabelCarousel(context, labels),
              ),
            ]));
  }

  /// Section Widget
  /// Section Widget
  Widget _buildHomeList(BuildContext context) {
    return BlocSelector<HomeListBloc, HomeListState, HomeListModel?>(
      selector: (state) => state.homeListModelObj,
      builder: (context, homeListModelObj) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: homeListModelObj?.homelistItemList.length ?? 0,
          itemBuilder: (context, index) {
            HomelistItemModel model =
                homeListModelObj?.homelistItemList[index] ??
                    HomelistItemModel();
            return Column(
              children: [
                HomelistItemWidget(model, onTapListItemListItem: () {
                  onTapListItemListItem(context);
                }),
                SizedBox(height: 2.v),
              ],
            );
          },
        );
      },
    );
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

  onTapFabMap(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.homeMapScreen);
  }

  Widget _buildFloatingMapButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: "map",
      mini: true,
      onPressed: () {
        onTapFabMap(context);
      },
      backgroundColor: appTheme.deepPurple5001,
      child: CustomImageView(
        imagePath: ImageConstant.imgSmallFab,
        height: 20,
        width: 20,
        color: appTheme.deepPurple500,
      ),
    );
  }
}

Widget _buildLabelCarousel(BuildContext context, List<LabelItemModel> labels) {
  return Container(
    height: 55.v,
    padding: EdgeInsets.symmetric(vertical: 6.v),
    decoration: AppDecoration.fillWhiteA,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) {
        return SizedBox(width: 13.h);
      },
      itemCount: labels.length,
      itemBuilder: (context, index) {
        LabelItemModel model = labels[index];
        return LabelWidget(
          imagePath: model.iconPath,
          labelText: model.label,
          value: model.value, // Pass the value here
        );
      },
    ),
  );
}
