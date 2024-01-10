// ignore_for_file: must_be_immutable

part of 'memory_journals_bloc.dart';

/// Represents the state of MemoryJournals in the application.
class MemoryJournalsState extends Equatable {
  MemoryJournalsState({this.memoryJournalsModelObj});

  MemoryJournalsModel? memoryJournalsModelObj;

  @override
  List<Object?> get props => [
        memoryJournalsModelObj,
      ];
  MemoryJournalsState copyWith({MemoryJournalsModel? memoryJournalsModelObj}) {
    return MemoryJournalsState(
      memoryJournalsModelObj:
          memoryJournalsModelObj ?? this.memoryJournalsModelObj,
    );
  }
}
