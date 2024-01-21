import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:anamnesis/presentation/duration_picker_bottomsheet/models/duration_picker_model.dart';
part 'duration_picker_event.dart';
part 'duration_picker_state.dart';

/// A bloc that manages the state of a DurationPicker according to the event that is dispatched to it.
class DurationPickerBloc
    extends Bloc<DurationPickerEvent, DurationPickerState> {
  DurationPickerBloc(DurationPickerState initialState) : super(initialState) {
    on<DurationPickerInitialEvent>(_onInitialize);
  }

  _onInitialize(
    DurationPickerInitialEvent event,
    Emitter<DurationPickerState> emit,
  ) async {}
}
