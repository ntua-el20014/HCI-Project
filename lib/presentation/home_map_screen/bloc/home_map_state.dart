// ignore_for_file: must_be_immutable

part of 'home_map_bloc.dart';

/// Represents the state of HomeMap in the application.
class HomeMapState extends Equatable {
  HomeMapState({this.homeMapModelObj});

  HomeMapModel? homeMapModelObj;

  @override
  List<Object?> get props => [
        homeMapModelObj,
      ];
  HomeMapState copyWith({HomeMapModel? homeMapModelObj}) {
    return HomeMapState(
      homeMapModelObj: homeMapModelObj ?? this.homeMapModelObj,
    );
  }
}
