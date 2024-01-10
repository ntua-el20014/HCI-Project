// ignore_for_file: must_be_immutable

part of 'memory_journals_journal_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///MemoryJournalsJournal widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class MemoryJournalsJournalEvent extends Equatable {}

/// Event that is dispatched when the MemoryJournalsJournal widget is first created.
class MemoryJournalsJournalInitialEvent extends MemoryJournalsJournalEvent {
  @override
  List<Object?> get props => [];
}
