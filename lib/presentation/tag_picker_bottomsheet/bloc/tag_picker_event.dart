// ignore_for_file: must_be_immutable

part of 'tag_picker_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///TagPicker widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class TagPickerEvent extends Equatable {}

/// Event that is dispatched when the TagPicker widget is first created.
class TagPickerInitialEvent extends TagPickerEvent {
  @override
  List<Object?> get props => [];
}
