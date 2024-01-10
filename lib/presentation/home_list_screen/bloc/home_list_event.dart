// ignore_for_file: must_be_immutable

part of 'home_list_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///HomeList widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class HomeListEvent extends Equatable {}

/// Event that is dispatched when the HomeList widget is first created.
class HomeListInitialEvent extends HomeListEvent {
  @override
  List<Object?> get props => [];
}
