import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:anamnesis/presentation/tag_picker_bottomsheet/models/tag_picker_model.dart';
part 'tag_picker_event.dart';
part 'tag_picker_state.dart';

/// A bloc that manages the state of a TagPicker according to the event that is dispatched to it.
class TagPickerBloc extends Bloc<TagPickerEvent, TagPickerState> {
  TagPickerBloc(TagPickerState initialState) : super(initialState) {
    on<TagPickerInitialEvent>(_onInitialize);
  }

  _onInitialize(
    TagPickerInitialEvent event,
    Emitter<TagPickerState> emit,
  ) async {
    emit(
        state.copyWith(tagPickerModelObj: state.tagPickerModelObj?.copyWith()));
  }
}
