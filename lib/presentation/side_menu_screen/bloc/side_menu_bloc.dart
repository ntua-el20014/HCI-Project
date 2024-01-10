import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:anamnesis/presentation/side_menu_screen/models/side_menu_model.dart';
part 'side_menu_event.dart';
part 'side_menu_state.dart';

/// A bloc that manages the state of a SideMenu according to the event that is dispatched to it.
class SideMenuBloc extends Bloc<SideMenuEvent, SideMenuState> {
  SideMenuBloc(SideMenuState initialState) : super(initialState) {
    on<SideMenuInitialEvent>(_onInitialize);
  }

  _onInitialize(
    SideMenuInitialEvent event,
    Emitter<SideMenuState> emit,
  ) async {}
}
