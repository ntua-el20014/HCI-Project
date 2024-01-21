// ignore_for_file: must_be_immutable

part of 'duration_picker_bloc.dart';

/// Represents the state of DurationPicker in the application.
class DurationPickerState extends Equatable {
  DurationPickerState({this.DurationPickerModelObj});

  DurationPickerModel? DurationPickerModelObj;

  @override
  List<Object?> get props => [
        DurationPickerModelObj,
      ];
  DurationPickerState copyWith({DurationPickerModel? DurationPickerModelObj}) {
    return DurationPickerState(
      DurationPickerModelObj:
          DurationPickerModelObj ?? this.DurationPickerModelObj,
    );
  }
}
