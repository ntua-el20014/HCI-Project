// ignore_for_file: must_be_immutable

part of 'memory_bloc.dart';

/// Represents the state of Memory in the application.
class MemoryState extends Equatable {
  MemoryState({
    this.isSelectedSwitch = false,
    this.memoryModelObj,
  });

  MemoryModel? memoryModelObj;

  bool isSelectedSwitch;

  @override
  List<Object?> get props => [
        isSelectedSwitch,
        memoryModelObj,
      ];
  MemoryState copyWith({
    bool? isSelectedSwitch,
    MemoryModel? memoryModelObj,
  }) {
    return MemoryState(
      isSelectedSwitch: isSelectedSwitch ?? this.isSelectedSwitch,
      memoryModelObj: memoryModelObj ?? this.memoryModelObj,
    );
  }
}
