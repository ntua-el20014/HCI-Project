import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:anamnesis/presentation/home_map_screen/models/home_map_model.dart';
part 'home_map_event.dart';
part 'home_map_state.dart';

/// A bloc that manages the state of a HomeMap according to the event that is dispatched to it.
class HomeMapBloc extends Bloc<HomeMapEvent, HomeMapState> {
  HomeMapBloc(HomeMapState initialState) : super(initialState) {
    on<HomeMapInitialEvent>(_onInitialize);
  }

  _onInitialize(
    HomeMapInitialEvent event,
    Emitter<HomeMapState> emit,
  ) async {
    NavigatorService.pushNamed(
      AppRoutes.homeListScreen,
    );
}
}
