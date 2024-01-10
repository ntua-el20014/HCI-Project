import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:anamnesis/presentation/memory_photos_photo_screen/models/memory_photos_photo_model.dart';
part 'memory_photos_photo_event.dart';
part 'memory_photos_photo_state.dart';

/// A bloc that manages the state of a MemoryPhotosPhoto according to the event that is dispatched to it.
class MemoryPhotosPhotoBloc
    extends Bloc<MemoryPhotosPhotoEvent, MemoryPhotosPhotoState> {
  MemoryPhotosPhotoBloc(MemoryPhotosPhotoState initialState)
      : super(initialState) {
    on<MemoryPhotosPhotoInitialEvent>(_onInitialize);
  }

  _onInitialize(
    MemoryPhotosPhotoInitialEvent event,
    Emitter<MemoryPhotosPhotoState> emit,
  ) async {}
}
