// ignore_for_file: must_be_immutable

part of 'memory_journals_journal_bloc.dart';

/// Represents the state of MemoryJournalsJournal in the application.
class MemoryJournalsJournalState extends Equatable {
  MemoryJournalsJournalState({this.memoryJournalsJournalModelObj});

  MemoryJournalsJournalModel? memoryJournalsJournalModelObj;

  @override
  List<Object?> get props => [
        memoryJournalsJournalModelObj,
      ];
  MemoryJournalsJournalState copyWith(
      {MemoryJournalsJournalModel? memoryJournalsJournalModelObj}) {
    return MemoryJournalsJournalState(
      memoryJournalsJournalModelObj:
          memoryJournalsJournalModelObj ?? this.memoryJournalsJournalModelObj,
    );
  }
}
