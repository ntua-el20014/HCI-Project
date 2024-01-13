import 'bloc/home_map_bloc.dart';
//import 'dart:async';
import 'models/home_map_model.dart';
import 'widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';

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
    return Container(
      color: Colors.black,
      child: Scaffold(
          body: SafeArea(
        child: Center(
          child: Map(),
        ),
      )),
    );
    // return BlocBuilder<HomeMapBloc, HomeMapState>(builder: (context, state) {
    //   return SafeArea(
    //       child: Scaffold(
    //           body: SizedBox(
    //               height: SizeUtils.height,
    //               width: double.maxFinite,
    //               child: Stack(alignment: Alignment.center, children: [
    //                 Align(
    //                     alignment: Alignment.center,
    //                     child: Container(
    //                         decoration: AppDecoration.fillBlue,
    //                         child: CustomImageView(
    //                             imagePath: ImageConstant.imgEarth,
    //                             height: 800.v,
    //                             width: 360.h))),
    //                 _buildHomeMap(context)
    //               ]))));
    // });
  }
}
