// ignore_for_file: must_be_immutable

part of 'memory_photos_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///MemoryPhotos widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class MemoryPhotosEvent extends Equatable {}

/// Event that is dispatched when the MemoryPhotos widget is first created.
class MemoryPhotosInitialEvent extends MemoryPhotosEvent {
  @override
  List<Object?> get props => [];
}
