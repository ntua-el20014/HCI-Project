// ignore_for_file: must_be_immutable

part of 'memory_photos_bloc.dart';

/// Represents the state of MemoryPhotos in the application.
class MemoryPhotosState extends Equatable {
  MemoryPhotosState({this.memoryPhotosModelObj});

  MemoryPhotosModel? memoryPhotosModelObj;

  @override
  List<Object?> get props => [
        memoryPhotosModelObj,
      ];
  MemoryPhotosState copyWith({MemoryPhotosModel? memoryPhotosModelObj}) {
    return MemoryPhotosState(
      memoryPhotosModelObj: memoryPhotosModelObj ?? this.memoryPhotosModelObj,
    );
  }
}
