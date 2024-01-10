// ignore_for_file: must_be_immutable

part of 'people_picker_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///PeoplePicker widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class PeoplePickerEvent extends Equatable {}

/// Event that is dispatched when the PeoplePicker widget is first created.
class PeoplePickerInitialEvent extends PeoplePickerEvent {
  @override
  List<Object?> get props => [];
}
