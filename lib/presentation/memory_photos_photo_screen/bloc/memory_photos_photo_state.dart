// ignore_for_file: must_be_immutable

part of 'memory_photos_photo_bloc.dart';

/// Represents the state of MemoryPhotosPhoto in the application.
class MemoryPhotosPhotoState extends Equatable {
  MemoryPhotosPhotoState({this.memoryPhotosPhotoModelObj});

  MemoryPhotosPhotoModel? memoryPhotosPhotoModelObj;

  @override
  List<Object?> get props => [
        memoryPhotosPhotoModelObj,
      ];
  MemoryPhotosPhotoState copyWith(
      {MemoryPhotosPhotoModel? memoryPhotosPhotoModelObj}) {
    return MemoryPhotosPhotoState(
      memoryPhotosPhotoModelObj:
          memoryPhotosPhotoModelObj ?? this.memoryPhotosPhotoModelObj,
    );
  }
}
