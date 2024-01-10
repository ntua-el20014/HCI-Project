import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../models/userprofile_item_model.dart';
import 'package:anamnesis/presentation/people_picker_bottomsheet/models/people_picker_model.dart';
part 'people_picker_event.dart';
part 'people_picker_state.dart';

/// A bloc that manages the state of a PeoplePicker according to the event that is dispatched to it.
class PeoplePickerBloc extends Bloc<PeoplePickerEvent, PeoplePickerState> {
  PeoplePickerBloc(PeoplePickerState initialState) : super(initialState) {
    on<PeoplePickerInitialEvent>(_onInitialize);
  }

  _onInitialize(
    PeoplePickerInitialEvent event,
    Emitter<PeoplePickerState> emit,
  ) async {
    emit(state.copyWith(
        peoplePickerModelObj: state.peoplePickerModelObj?.copyWith(
      userprofileItemList: fillUserprofileItemList(),
    )));
  }

  List<UserprofileItemModel> fillUserprofileItemList() {
    return [
      UserprofileItemModel(
          userImage: ImageConstant.imgLock, headlineText: "Person"),
      UserprofileItemModel(
          userImage: ImageConstant.imgLock, headlineText: "Person"),
      UserprofileItemModel(
          userImage: ImageConstant.imgLock, headlineText: "Person"),
      UserprofileItemModel(
          userImage: ImageConstant.imgLock, headlineText: "Person"),
      UserprofileItemModel(
          userImage: ImageConstant.imgLock, headlineText: "Person"),
      UserprofileItemModel(
          userImage: ImageConstant.imgLock, headlineText: "Person")
    ];
  }
}
