import 'bloc/home_map_bloc.dart';
import 'dart:async';
import 'models/home_map_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:anamnesis/core/app_export.dart';

// ignore_for_file: must_be_immutable
class HomeMapScreen extends StatelessWidget {
  HomeMapScreen({Key? key}) : super(key: key);

  Completer<GoogleMapController> googleMapController = Completer();

  static Widget builder(BuildContext context) {
    return BlocProvider<HomeMapBloc>(
        create: (context) =>
            HomeMapBloc(HomeMapState(homeMapModelObj: HomeMapModel()))
              ..add(HomeMapInitialEvent()),
        child: HomeMapScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeMapBloc, HomeMapState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              body: SizedBox(
                  height: SizeUtils.height,
                  width: double.maxFinite,
                  child: Stack(alignment: Alignment.center, children: [
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                            decoration: AppDecoration.fillBlue,
                            child: CustomImageView(
                                imagePath: ImageConstant.imgEarth,
                                height: 800.v,
                                width: 360.h))),
                    _buildHomeMap(context)
                  ]))));
    });
  }

  /// Section Widget
  Widget _buildHomeMap(BuildContext context) {
    return SizedBox(
        height: 771.v,
        width: double.maxFinite,
        child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: LatLng(37.43296265331129, -122.08832357078792),
                zoom: 14.4746),
            onMapCreated: (GoogleMapController controller) {
              googleMapController.complete(controller);
            },
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: false));
  }
}
