// ignore_for_file: must_be_immutable

part of 'people_picker_bloc.dart';

/// Represents the state of PeoplePicker in the application.
class PeoplePickerState extends Equatable {
  PeoplePickerState({this.peoplePickerModelObj});

  PeoplePickerModel? peoplePickerModelObj;

  @override
  List<Object?> get props => [
        peoplePickerModelObj,
      ];
  PeoplePickerState copyWith({PeoplePickerModel? peoplePickerModelObj}) {
    return PeoplePickerState(
      peoplePickerModelObj: peoplePickerModelObj ?? this.peoplePickerModelObj,
    );
  }
}
