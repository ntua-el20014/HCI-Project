import 'package:anamnesis/database/database.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import '/core/app_export.dart';
import '../models/photoscarousel_item_model.dart';
import '../models/userprofile1_item_model.dart';
import 'package:anamnesis/presentation/memory_screen/models/memory_model.dart';
part 'memory_event.dart';
part 'memory_state.dart';

/// A bloc that manages the state of a Memory according to the event that is dispatched to it.
class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  final int memId;

  MemoryBloc(this.memId, MemoryState initialState) : super(initialState) {
    on<MemoryInitialEvent>(_onInitialize);
    on<ChangeSwitchEvent>(_changeSwitch);
  }

  _changeSwitch(
    ChangeSwitchEvent event,
    Emitter<MemoryState> emit,
  ) {
    emit(state.copyWith(isSelectedSwitch: event.value));
  }

  List<PhotoscarouselItemModel> fillPhotoscarouselItemList() {
    return [
      PhotoscarouselItemModel(carouselItem: ImageConstant.imgCarouselItem),
      PhotoscarouselItemModel(
          carouselItem: ImageConstant.imgCarouselItem172x122)
    ];
  }

  List<Userprofile1ItemModel> fillUserprofile1ItemList() {
    return [
      Userprofile1ItemModel(
          dateTimeText: "DD/MM HH:MM ", durationText: "Duration"),
      Userprofile1ItemModel(
          dateTimeText: "DD/MM HH:MM ", durationText: "Duration"),
      Userprofile1ItemModel(
          dateTimeText: "DD/MM HH:MM ", durationText: "Duration"),
      Userprofile1ItemModel(
          dateTimeText: "DD/MM HH:MM ", durationText: "Duration")
    ];
  }

  _onInitialize(
    MemoryInitialEvent event,
    Emitter<MemoryState> emit,
  ) async {
    DatabaseHelper dbHelp = DatabaseHelper();
    Map<String, dynamic> memory = await dbHelp.getMemoryInfo(memId);

    String startDate =
        "${memory['start_date'].day}/${memory['start_date'].month}/${memory['start_date'].year}";
    String endDate =
        "${memory['end_date'].day}/${memory['end_date'].month}/${memory['end_date'].year}";
    String location = await _getPlacemarkFromCoordinates(memory['location']);

    emit(state.copyWith(isSelectedSwitch: false));
    emit(state.copyWith(
        memoryModelObj: state.memoryModelObj?.copyWith(
            id: memory['id'],
            title: memory['title'],
            thumbnail: memory['thumbnail'],
            start_date: startDate,
            end_date: endDate,
            location: location,
            images: memory['images'],
            recordings: memory['recordings'],
            tags: memory['tags'],
            people: memory['people'],
            photoscarouselItemList: fillPhotoscarouselItemList(),
            userprofile1ItemList: fillUserprofile1ItemList(),
            loaded: true)));
  }
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
