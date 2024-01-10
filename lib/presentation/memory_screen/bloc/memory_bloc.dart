import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../models/photoscarousel_item_model.dart';
import '../models/userprofile1_item_model.dart';
import 'package:anamnesis/presentation/memory_screen/models/memory_model.dart';
part 'memory_event.dart';
part 'memory_state.dart';

/// A bloc that manages the state of a Memory according to the event that is dispatched to it.
class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  MemoryBloc(MemoryState initialState) : super(initialState) {
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
    emit(state.copyWith(isSelectedSwitch: false));
    emit(state.copyWith(
        memoryModelObj: state.memoryModelObj?.copyWith(
            photoscarouselItemList: fillPhotoscarouselItemList(),
            userprofile1ItemList: fillUserprofile1ItemList())));
  }
}
