// ignore_for_file: must_be_immutable

part of 'create_memory_bloc.dart';

/// Represents the state of CreateMemory in the application.
class CreateMemoryState extends Equatable {
  CreateMemoryState({
    this.titleController,
    this.dateController,
    this.dateController1,
    this.dateController2,
    this.locationController,
    this.selectedDropDownValue,
    this.selectedDropDownValue1,
    this.createMemoryModelObj,
  });

  TextEditingController? titleController;

  TextEditingController? dateController;

  TextEditingController? dateController1;

  TextEditingController? dateController2;

  TextEditingController? locationController;

  SelectionPopupModel? selectedDropDownValue;

  SelectionPopupModel? selectedDropDownValue1;

  CreateMemoryModel? createMemoryModelObj;

  @override
  List<Object?> get props => [
        titleController,
        dateController,
        dateController1,
        dateController2,
        locationController,
        selectedDropDownValue,
        selectedDropDownValue1,
        createMemoryModelObj,
      ];
  CreateMemoryState copyWith({
    TextEditingController? titleController,
    TextEditingController? dateController,
    TextEditingController? dateController1,
    TextEditingController? dateController2,
    TextEditingController? locationController,
    SelectionPopupModel? selectedDropDownValue,
    SelectionPopupModel? selectedDropDownValue1,
    CreateMemoryModel? createMemoryModelObj,
  }) {
    return CreateMemoryState(
      titleController: titleController ?? this.titleController,
      dateController: dateController ?? this.dateController,
      dateController1: dateController1 ?? this.dateController1,
      dateController2: dateController2 ?? this.dateController2,
      locationController: locationController ?? this.locationController,
      selectedDropDownValue:
          selectedDropDownValue ?? this.selectedDropDownValue,
      selectedDropDownValue1:
          selectedDropDownValue1 ?? this.selectedDropDownValue1,
      createMemoryModelObj: createMemoryModelObj ?? this.createMemoryModelObj,
    );
  }
}
