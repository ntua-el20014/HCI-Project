import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../models/memoryphotos_item_model.dart';
import '../models/memoryphotos1_item_model.dart';
import 'package:anamnesis/presentation/memory_photos_screen/models/memory_photos_model.dart';
part 'memory_photos_event.dart';
part 'memory_photos_state.dart';

/// A bloc that manages the state of a MemoryPhotos according to the event that is dispatched to it.
class MemoryPhotosBloc extends Bloc<MemoryPhotosEvent, MemoryPhotosState> {
  MemoryPhotosBloc(MemoryPhotosState initialState) : super(initialState) {
    on<MemoryPhotosInitialEvent>(_onInitialize);
  }

  _onInitialize(
    MemoryPhotosInitialEvent event,
    Emitter<MemoryPhotosState> emit,
  ) async {
    emit(state.copyWith(
        memoryPhotosModelObj: state.memoryPhotosModelObj?.copyWith(
      memoryphotosItemList: fillMemoryphotosItemList(),
    )));
  }

  List<MemoryphotosItemModel> fillMemoryphotosItemList() {
    return [
      MemoryphotosItemModel(dayText: "Day DD/MM/YY"),
      MemoryphotosItemModel(dayText: "Day DD/MM/YY"),
      MemoryphotosItemModel(dayText: "Day DD/MM/YY")
    ];
  }

  List<Memoryphotos1ItemModel> fillMemoryphotos1ItemList() {
    return [
      Memoryphotos1ItemModel(
          image1: ImageConstant.imgMikrhMprostinhStampaOmada),
      Memoryphotos1ItemModel(image1: ImageConstant.imgPeriodikosPinakas),
      Memoryphotos1ItemModel(image1: ImageConstant.imgThumbnail),
      Memoryphotos1ItemModel(image1: ImageConstant.imgPeriodikosPinakas134x121),
      Memoryphotos1ItemModel(
          image1: ImageConstant.imgMikrhMprostinhStampaOmada134x119),
      Memoryphotos1ItemModel(image1: ImageConstant.imgPeriodikosPinakas134x120)
    ];
  }
}
