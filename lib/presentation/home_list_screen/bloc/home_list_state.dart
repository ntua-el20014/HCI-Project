// ignore_for_file: must_be_immutable

part of 'home_list_bloc.dart';

/// Represents the state of HomeList in the application.
class HomeListState extends Equatable {
  HomeListState({
    this.searchController,
    //this.tagController,
    this.homeListModelObj,
  });

  TextEditingController? searchController;

  //TextEditingController? tagController;

  HomeListModel? homeListModelObj;

  @override
  List<Object?> get props => [
        searchController,
        //tagController,
        homeListModelObj,
      ];
  HomeListState copyWith({
    TextEditingController? searchController,
    //TextEditingController? tagController,
    HomeListModel? homeListModelObj,
  }) {
    return HomeListState(
      searchController: searchController ?? this.searchController,
      //tagController: tagController ?? this.tagController,
      homeListModelObj: homeListModelObj ?? this.homeListModelObj,
    );
  }
}

class FilterMemoriesEvent extends HomeListEvent {
  final String searchText;
  final List<PeopleItemModel> selectedPeople;
  final List<int> selectedTags;

  FilterMemoriesEvent({
    required this.searchText,
    required this.selectedPeople,
    required this.selectedTags,
  });

  @override
  List<Object?> get props => [searchText, selectedPeople, selectedTags];
}
