import 'package:anamnesis/database/database.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '/core/app_export.dart';
import '../models/homelist_item_model.dart';
import 'package:anamnesis/presentation/home_list_screen/models/home_list_model.dart';
import 'package:geocoding/geocoding.dart';
part 'home_list_event.dart';
part 'home_list_state.dart';

/// A bloc that manages the state of a HomeList according to the event that is dispatched to it.
class HomeListBloc extends Bloc<HomeListEvent, HomeListState> {
  HomeListBloc(HomeListState initialState) : super(initialState) {
    on<HomeListInitialEvent>(_onInitialize);
  }

  Future<List<HomelistItemModel>> fillHomelistItemList() async {
    List<HomelistItemModel> homeList = [];
    DatabaseHelper dbHelp = DatabaseHelper();
    List<Map<String, dynamic>> memories = await dbHelp.getMemories();
    for (int i = 0; i < memories.length; i++) {
      String dateOnly =
          "${memories[i]['start_date'].day}/${memories[i]['start_date'].month}/${memories[i]['start_date'].year}";
      print("date: $dateOnly");
      String placemark =
          await _getPlacemarkFromCoordinates(memories[i]['location']);

      homeList.add(HomelistItemModel(
        date: memories[i]['thumbnail'],
        overlineText: dateOnly,
        headlineText: memories[i]['title'],
        supportingText: placemark,
      ));
    }
    return homeList;
  }

  Future<String> _getPlacemarkFromCoordinates(LatLng coordinates) async {
    double latitude = coordinates.latitude;
    double longitude = coordinates.longitude;

    try {
      // Get name
      List<Placemark> locationNameCandidates =
          await placemarkFromCoordinates(latitude, longitude);
      String locationName = locationNameCandidates.first.locality.toString();

      return locationName;
    } catch (e) {
      return 'Middle of nowhere';
    }
  }

  _onInitialize(HomeListInitialEvent event, Emitter<HomeListState> emit) async {
    emit(state.copyWith(
        searchController: TextEditingController(),
        tagController: TextEditingController()));
    emit(state.copyWith(
        homeListModelObj: state.homeListModelObj
            ?.copyWith(homelistItemList: await fillHomelistItemList())));
  }
}
