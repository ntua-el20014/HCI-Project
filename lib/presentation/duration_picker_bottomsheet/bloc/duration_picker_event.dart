// ignore_for_file: must_be_immutable

part of 'duration_picker_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///DurationPicker widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class DurationPickerEvent extends Equatable {}

/// Event that is dispatched when the DurationPicker widget is first created.
class DurationPickerInitialEvent extends DurationPickerEvent {
  @override
  List<Object?> get props => [];
}
