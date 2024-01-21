// ignore_for_file: must_be_immutable

part of 'home_map_bloc.dart';

/// Represents the state of HomeMap in the application.
class HomeMapState extends Equatable {
  HomeMapState({
    this.searchController,
    //this.tagController,
    this.homeMapModelObj,
  });

  TextEditingController? searchController;

  //TextEditingController? tagController;

  HomeMapModel? homeMapModelObj;

  @override
  List<Object?> get props => [
        searchController,
        //tagController,
        homeMapModelObj,
      ];
  HomeMapState copyWith(
      {TextEditingController? searchController,
      //TextEditingController? tagController,
      HomeMapModel? homeMapModelObj}) {
    return HomeMapState(
      searchController: searchController ?? this.searchController,
      //tagController: tagController ?? this.tagController,
      homeMapModelObj: homeMapModelObj ?? this.homeMapModelObj,
    );
  }
}
