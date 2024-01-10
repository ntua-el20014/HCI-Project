import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../models/homelist_item_model.dart';
import 'package:anamnesis/presentation/home_list_screen/models/home_list_model.dart';
part 'home_list_event.dart';
part 'home_list_state.dart';

/// A bloc that manages the state of a HomeList according to the event that is dispatched to it.
class HomeListBloc extends Bloc<HomeListEvent, HomeListState> {
  HomeListBloc(HomeListState initialState) : super(initialState) {
    on<HomeListInitialEvent>(_onInitialize);
  }

  List<HomelistItemModel> fillHomelistItemList() {
    return [
      HomelistItemModel(
          date: ImageConstant.imgThumbnail,
          overlineText: "dd / mm / yyyy",
          headlineText: "Memory Title",
          smallFAB: ImageConstant.imgSmallFab,
          supportingText:
              "Supporting line text lorem ipsum dolor sit amet, consectetur."),
      HomelistItemModel(date: ImageConstant.imgThumbnail56x56),
      HomelistItemModel(date: ImageConstant.imgThumbnail1),
      HomelistItemModel(date: ImageConstant.imgThumbnail),
      HomelistItemModel(date: ImageConstant.imgThumbnail56x56),
      HomelistItemModel(date: ImageConstant.imgThumbnail1),
      HomelistItemModel(date: ImageConstant.imgThumbnail56x56)
    ];
  }

  _onInitialize(
    HomeListInitialEvent event,
    Emitter<HomeListState> emit,
  ) async {
    emit(state.copyWith(
        searchController: TextEditingController(),
        tagController: TextEditingController()));
    emit(state.copyWith(
        homeListModelObj: state.homeListModelObj
            ?.copyWith(homelistItemList: fillHomelistItemList())));
  }
}
