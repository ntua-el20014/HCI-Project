// ignore_for_file: must_be_immutable

part of 'memory_photos_photo_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///MemoryPhotosPhoto widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class MemoryPhotosPhotoEvent extends Equatable {}

/// Event that is dispatched when the MemoryPhotosPhoto widget is first created.
class MemoryPhotosPhotoInitialEvent extends MemoryPhotosPhotoEvent {
  @override
  List<Object?> get props => [];
}
