// ignore_for_file: must_be_immutable

part of 'memory_map_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///MemoryMap widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class MemoryMapEvent extends Equatable {}

/// Event that is dispatched when the MemoryMap widget is first created.
class MemoryMapInitialEvent extends MemoryMapEvent {
  @override
  List<Object?> get props => [];
}
