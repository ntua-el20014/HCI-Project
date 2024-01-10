// ignore_for_file: must_be_immutable

part of 'create_memory_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///CreateMemory widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class CreateMemoryEvent extends Equatable {}

/// Event that is dispatched when the CreateMemory widget is first created.
class CreateMemoryInitialEvent extends CreateMemoryEvent {
  @override
  List<Object?> get props => [];
}

///event for dropdown selection
class ChangeDropDownEvent extends CreateMemoryEvent {
  ChangeDropDownEvent({required this.value});

  SelectionPopupModel value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///event for dropdown selection
class ChangeDropDown1Event extends CreateMemoryEvent {
  ChangeDropDown1Event({required this.value});

  SelectionPopupModel value;

  @override
  List<Object?> get props => [
        value,
      ];
}
