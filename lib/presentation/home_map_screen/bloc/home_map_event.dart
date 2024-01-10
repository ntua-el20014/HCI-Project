// ignore_for_file: must_be_immutable

part of 'home_map_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///HomeMap widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class HomeMapEvent extends Equatable {}

/// Event that is dispatched when the HomeMap widget is first created.
class HomeMapInitialEvent extends HomeMapEvent {
  @override
  List<Object?> get props => [];
}
