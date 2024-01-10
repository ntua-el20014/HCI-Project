import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../models/memoryjournals_item_model.dart';
import 'package:anamnesis/presentation/memory_journals_screen/models/memory_journals_model.dart';
part 'memory_journals_event.dart';
part 'memory_journals_state.dart';

/// A bloc that manages the state of a MemoryJournals according to the event that is dispatched to it.
class MemoryJournalsBloc
    extends Bloc<MemoryJournalsEvent, MemoryJournalsState> {
  MemoryJournalsBloc(MemoryJournalsState initialState) : super(initialState) {
    on<MemoryJournalsInitialEvent>(_onInitialize);
  }

  _onInitialize(
    MemoryJournalsInitialEvent event,
    Emitter<MemoryJournalsState> emit,
  ) async {
    emit(state.copyWith(
        memoryJournalsModelObj: state.memoryJournalsModelObj
            ?.copyWith(memoryjournalsItemList: fillMemoryjournalsItemList())));
  }

  List<MemoryjournalsItemModel> fillMemoryjournalsItemList() {
    return [
      MemoryjournalsItemModel(dynamicText: "Journal DD/MM/YY"),
      MemoryjournalsItemModel(dynamicText: "Journal DD/MM/YY"),
      MemoryjournalsItemModel(dynamicText: "Journal DD/MM/YY"),
      MemoryjournalsItemModel(dynamicText: "Journal DD/MM/YY")
    ];
  }
}
