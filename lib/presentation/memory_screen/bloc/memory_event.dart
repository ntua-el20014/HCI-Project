// ignore_for_file: must_be_immutable

part of 'memory_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Memory widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class MemoryEvent extends Equatable {}

/// Event that is dispatched when the Memory widget is first created.
class MemoryInitialEvent extends MemoryEvent {
  final int memId;

  MemoryInitialEvent(this.memId);

  @override
  List<Object?> get props => [];
}

///Event for changing switch
class ChangeSwitchEvent extends MemoryEvent {
  ChangeSwitchEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}
