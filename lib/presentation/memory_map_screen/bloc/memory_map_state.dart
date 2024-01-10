// ignore_for_file: must_be_immutable

part of 'memory_map_bloc.dart';

/// Represents the state of MemoryMap in the application.
class MemoryMapState extends Equatable {
  MemoryMapState({this.memoryMapModelObj});

  MemoryMapModel? memoryMapModelObj;

  @override
  List<Object?> get props => [
        memoryMapModelObj,
      ];
  MemoryMapState copyWith({MemoryMapModel? memoryMapModelObj}) {
    return MemoryMapState(
      memoryMapModelObj: memoryMapModelObj ?? this.memoryMapModelObj,
    );
  }
}
