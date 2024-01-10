// ignore_for_file: must_be_immutable

part of 'memory_journals_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///MemoryJournals widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class MemoryJournalsEvent extends Equatable {}

/// Event that is dispatched when the MemoryJournals widget is first created.
class MemoryJournalsInitialEvent extends MemoryJournalsEvent {
  @override
  List<Object?> get props => [];
}
