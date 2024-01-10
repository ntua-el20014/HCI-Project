// ignore_for_file: must_be_immutable

part of 'side_menu_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///SideMenu widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class SideMenuEvent extends Equatable {}

/// Event that is dispatched when the SideMenu widget is first created.
class SideMenuInitialEvent extends SideMenuEvent {
  @override
  List<Object?> get props => [];
}
