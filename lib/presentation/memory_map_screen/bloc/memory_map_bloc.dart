import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:anamnesis/presentation/memory_map_screen/models/memory_map_model.dart';
part 'memory_map_event.dart';
part 'memory_map_state.dart';

/// A bloc that manages the state of a MemoryMap according to the event that is dispatched to it.
class MemoryMapBloc extends Bloc<MemoryMapEvent, MemoryMapState> {
  MemoryMapBloc(MemoryMapState initialState) : super(initialState) {
    on<MemoryMapInitialEvent>(_onInitialize);
  }

  _onInitialize(
    MemoryMapInitialEvent event,
    Emitter<MemoryMapState> emit,
  ) async {}
}
