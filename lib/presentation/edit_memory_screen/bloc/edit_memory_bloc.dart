import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:anamnesis/presentation/edit_memory_screen/models/edit_memory_model.dart';
part 'edit_memory_event.dart';
part 'edit_memory_state.dart';

/// A bloc that manages the state of a EditMemory according to the event that is dispatched to it.
class EditMemoryBloc extends Bloc<EditMemoryEvent, EditMemoryState> {
  EditMemoryBloc(EditMemoryState initialState) : super(initialState) {
    on<EditMemoryInitialEvent>(_onInitialize);
    on<ChangeDropDownEvent>(_changeDropDown);
    on<ChangeDropDown1Event>(_changeDropDown1);
  }

  _changeDropDown(
    ChangeDropDownEvent event,
    Emitter<EditMemoryState> emit,
  ) {
    emit(state.copyWith(
      selectedDropDownValue: event.value,
    ));
  }

  _changeDropDown1(
    ChangeDropDown1Event event,
    Emitter<EditMemoryState> emit,
  ) {
    emit(state.copyWith(
      selectedDropDownValue1: event.value,
    ));
  }

  List<SelectionPopupModel> fillDropdownItemList() {
    return [
      SelectionPopupModel(
        id: 1,
        title: "Item One",
        isSelected: true,
      ),
      SelectionPopupModel(
        id: 2,
        title: "Item Two",
      ),
      SelectionPopupModel(
        id: 3,
        title: "Item Three",
      )
    ];
  }

  List<SelectionPopupModel> fillDropdownItemList1() {
    return [
      SelectionPopupModel(
        id: 1,
        title: "Item One",
        isSelected: true,
      ),
      SelectionPopupModel(
        id: 2,
        title: "Item Two",
      ),
      SelectionPopupModel(
        id: 3,
        title: "Item Three",
      )
    ];
  }

  _onInitialize(
    EditMemoryInitialEvent event,
    Emitter<EditMemoryState> emit,
  ) async {
    emit(state.copyWith(
      titleController: TextEditingController(),
      dateController: TextEditingController(),
      startDateController: TextEditingController(),
      endDateController: TextEditingController(),
      locationController: TextEditingController(),
    ));
    emit(state.copyWith(
        editMemoryModelObj: state.editMemoryModelObj?.copyWith(
      dropdownItemList: fillDropdownItemList(),
      dropdownItemList1: fillDropdownItemList1(),
    )));
  }
}
