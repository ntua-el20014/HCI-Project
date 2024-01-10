// ignore_for_file: must_be_immutable

part of 'date_picker_bloc.dart';

/// Represents the state of DatePicker in the application.
class DatePickerState extends Equatable {
  DatePickerState({
    this.selectedDatesFromCalendar1,
    this.datePickerModelObj,
  });

  DatePickerModel? datePickerModelObj;

  List<DateTime?>? selectedDatesFromCalendar1;

  @override
  List<Object?> get props => [
        selectedDatesFromCalendar1,
        datePickerModelObj,
      ];
  DatePickerState copyWith({
    List<DateTime?>? selectedDatesFromCalendar1,
    DatePickerModel? datePickerModelObj,
  }) {
    return DatePickerState(
      selectedDatesFromCalendar1:
          selectedDatesFromCalendar1 ?? this.selectedDatesFromCalendar1,
      datePickerModelObj: datePickerModelObj ?? this.datePickerModelObj,
    );
  }
}
