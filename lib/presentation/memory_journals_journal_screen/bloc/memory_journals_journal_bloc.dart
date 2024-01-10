import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:anamnesis/presentation/memory_journals_journal_screen/models/memory_journals_journal_model.dart';
part 'memory_journals_journal_event.dart';
part 'memory_journals_journal_state.dart';

/// A bloc that manages the state of a MemoryJournalsJournal according to the event that is dispatched to it.
class MemoryJournalsJournalBloc
    extends Bloc<MemoryJournalsJournalEvent, MemoryJournalsJournalState> {
  MemoryJournalsJournalBloc(MemoryJournalsJournalState initialState)
      : super(initialState) {
    on<MemoryJournalsJournalInitialEvent>(_onInitialize);
  }

  _onInitialize(
    MemoryJournalsJournalInitialEvent event,
    Emitter<MemoryJournalsJournalState> emit,
  ) async {}
}
