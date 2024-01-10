// ignore_for_file: must_be_immutable

part of 'edit_memory_bloc.dart';

/// Represents the state of EditMemory in the application.
class EditMemoryState extends Equatable {
  EditMemoryState({
    this.titleController,
    this.dateController,
    this.startDateController,
    this.endDateController,
    this.locationController,
    this.selectedDropDownValue,
    this.selectedDropDownValue1,
    this.editMemoryModelObj,
  });

  TextEditingController? titleController;

  TextEditingController? dateController;

  TextEditingController? startDateController;

  TextEditingController? endDateController;

  TextEditingController? locationController;

  SelectionPopupModel? selectedDropDownValue;

  SelectionPopupModel? selectedDropDownValue1;

  EditMemoryModel? editMemoryModelObj;

  @override
  List<Object?> get props => [
        titleController,
        dateController,
        startDateController,
        endDateController,
        locationController,
        selectedDropDownValue,
        selectedDropDownValue1,
        editMemoryModelObj,
      ];
  EditMemoryState copyWith({
    TextEditingController? titleController,
    TextEditingController? dateController,
    TextEditingController? startDateController,
    TextEditingController? endDateController,
    TextEditingController? locationController,
    SelectionPopupModel? selectedDropDownValue,
    SelectionPopupModel? selectedDropDownValue1,
    EditMemoryModel? editMemoryModelObj,
  }) {
    return EditMemoryState(
      titleController: titleController ?? this.titleController,
      dateController: dateController ?? this.dateController,
      startDateController: startDateController ?? this.startDateController,
      endDateController: endDateController ?? this.endDateController,
      locationController: locationController ?? this.locationController,
      selectedDropDownValue:
          selectedDropDownValue ?? this.selectedDropDownValue,
      selectedDropDownValue1:
          selectedDropDownValue1 ?? this.selectedDropDownValue1,
      editMemoryModelObj: editMemoryModelObj ?? this.editMemoryModelObj,
    );
  }
}
