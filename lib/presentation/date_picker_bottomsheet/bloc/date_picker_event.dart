// ignore_for_file: must_be_immutable

part of 'date_picker_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///DatePicker widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class DatePickerEvent extends Equatable {}

/// Event that is dispatched when the DatePicker widget is first created.
class DatePickerInitialEvent extends DatePickerEvent {
  @override
  List<Object?> get props => [];
}
