import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:anamnesis/presentation/date_picker_bottomsheet/models/date_picker_model.dart';
part 'date_picker_event.dart';
part 'date_picker_state.dart';

/// A bloc that manages the state of a DatePicker according to the event that is dispatched to it.
class DatePickerBloc extends Bloc<DatePickerEvent, DatePickerState> {
  DatePickerBloc(DatePickerState initialState) : super(initialState) {
    on<DatePickerInitialEvent>(_onInitialize);
  }

  _onInitialize(
    DatePickerInitialEvent event,
    Emitter<DatePickerState> emit,
  ) async {}
}
