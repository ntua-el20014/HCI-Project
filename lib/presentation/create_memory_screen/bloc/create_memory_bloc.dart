import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:anamnesis/presentation/create_memory_screen/models/create_memory_model.dart';
part 'create_memory_event.dart';
part 'create_memory_state.dart';

/// A bloc that manages the state of a CreateMemory according to the event that is dispatched to it.
class CreateMemoryBloc extends Bloc<CreateMemoryEvent, CreateMemoryState> {
  CreateMemoryBloc(CreateMemoryState initialState) : super(initialState) {
    on<CreateMemoryInitialEvent>(_onInitialize);
    on<ChangeDropDownEvent>(_changeDropDown);
    on<ChangeDropDown1Event>(_changeDropDown1);
  }

  _changeDropDown(
    ChangeDropDownEvent event,
    Emitter<CreateMemoryState> emit,
  ) {
    emit(state.copyWith(
      selectedDropDownValue: event.value,
    ));
  }

  _changeDropDown1(
    ChangeDropDown1Event event,
    Emitter<CreateMemoryState> emit,
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
    CreateMemoryInitialEvent event,
    Emitter<CreateMemoryState> emit,
  ) async {
    emit(state.copyWith(
      titleController: TextEditingController(),
      dateController: TextEditingController(),
      dateController1: TextEditingController(),
      dateController2: TextEditingController(),
      locationController: TextEditingController(),
    ));
    emit(state.copyWith(
        createMemoryModelObj: state.createMemoryModelObj?.copyWith(
      dropdownItemList: fillDropdownItemList(),
      dropdownItemList1: fillDropdownItemList1(),
    )));
  }
}
