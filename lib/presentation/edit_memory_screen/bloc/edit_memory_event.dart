// ignore_for_file: must_be_immutable

part of 'edit_memory_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///EditMemory widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class EditMemoryEvent extends Equatable {}

/// Event that is dispatched when the EditMemory widget is first created.
class EditMemoryInitialEvent extends EditMemoryEvent {
  @override
  List<Object?> get props => [];
}

///event for dropdown selection
class ChangeDropDownEvent extends EditMemoryEvent {
  ChangeDropDownEvent({required this.value});

  SelectionPopupModel value;

  @override
  List<Object?> get props => [
        value,
      ];
}

///event for dropdown selection
class ChangeDropDown1Event extends EditMemoryEvent {
  ChangeDropDown1Event({required this.value});

  SelectionPopupModel value;

  @override
  List<Object?> get props => [
        value,
      ];
}
