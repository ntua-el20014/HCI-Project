import 'bloc/home_map_bloc.dart';
//import 'dart:async';
import 'models/home_map_model.dart';
import 'widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/widgets/custom_floating_button.dart';
import 'package:anamnesis/widgets/custom_search_view.dart';
import '../home_list_screen/models/label_item_model.dart';
import '../home_list_screen/widgets/label_widget.dart';

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

// ignore_for_file: must_be_immutable
class HomeMapScreen extends StatelessWidget {
  HomeMapScreen({Key? key}) : super(key: key);
  static Widget builder(BuildContext context) {
    return BlocProvider<HomeMapBloc>(
        create: (context) =>
            HomeMapBloc(HomeMapState(homeMapModelObj: HomeMapModel()))
              ..add(HomeMapInitialEvent()),
        child: HomeMapScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: [
              MapWidget(),
              Column(
                children: [
                  _buildSearchPanel(context),
                  Align(
                    alignment: Alignment.topRight,
                    child: _buildFloatingListButton(context),
                  ),
                ],
              ),
            ],
          ),
          floatingActionButton: _buildFloatingActionButton(context)),
    );
  }

  Widget _buildSearchPanel(BuildContext context) {
    return Container(
        // color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 5.v),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocSelector<HomeMapBloc, HomeMapState, TextEditingController?>(
                  selector: (state) => state.searchController,
                  builder: (context, searchController) {
                    return CustomSearchView(
                        hasShadow: true,
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

  Widget _buildLabelCarousel(
      BuildContext context, List<LabelItemModel> labels) {
    return Container(
      height: 55.v,
      padding: EdgeInsets.only(top: 6.v),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(width: 13.h);
        },
        itemCount: labels.length,
        itemBuilder: (context, index) {
          LabelItemModel model = labels[index];
          return LabelWidget(
            hasShadow: true,
            imagePath: model.iconPath,
            labelText: model.label,
            value: model.value, // Pass the value here
          );
        },
      ),
    );
  }

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
}

onTapFabList(BuildContext context) {
  NavigatorService.pushNamed(AppRoutes.homeListScreen);
}

Widget _buildFloatingListButton(BuildContext context) {
  return FloatingActionButton(
    heroTag: "list",
    mini: true,
    onPressed: () {
      onTapFabList(context);
    },
    backgroundColor: appTheme.deepPurple5001,
    child: Icon(
      Icons.list,
      color: appTheme.deepPurple500,
    ),
  );
}
