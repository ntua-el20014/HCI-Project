// ignore_for_file: must_be_immutable

part of 'home_list_bloc.dart';

/// Represents the state of HomeList in the application.
class HomeListState extends Equatable {
  HomeListState({
    this.searchController,
    //this.tagController,
    this.homeListModelObj,
    this.existingSearchText,
    this.existingSelectedPeople,
    this.existingSelectedTags,
    this.existingDate,
    this.existingDuration,
  });

  TextEditingController? searchController;

  //TextEditingController? tagController;

  HomeListModel? homeListModelObj;

  // Existing filters
  String? existingSearchText;
  List<PeopleItemModel>? existingSelectedPeople;
  List<int>? existingSelectedTags;
  List<DateTime>? existingDate;
  int? existingDuration;

  @override
  List<Object?> get props => [
        searchController,
        //tagController,
        homeListModelObj,
        existingSearchText,
        existingSelectedPeople,
        existingSelectedTags,
        existingDate,
        existingDuration,
      ];

  HomeListState copyWith({
    TextEditingController? searchController,
    //TextEditingController? tagController,
    HomeListModel? homeListModelObj,
    String? existingSearchText,
    List<PeopleItemModel>? existingSelectedPeople,
    List<int>? existingSelectedTags,
    List<DateTime>? existingDate,
    int? existingDuration,
  }) {
    return HomeListState(
      searchController: searchController ?? this.searchController,
      //tagController: tagController ?? this.tagController,
      homeListModelObj: homeListModelObj ?? this.homeListModelObj,
      existingSearchText: existingSearchText ?? this.existingSearchText,
      existingSelectedPeople:
          existingSelectedPeople ?? this.existingSelectedPeople,
      existingSelectedTags: existingSelectedTags ?? this.existingSelectedTags,
      existingDate: existingDate ?? this.existingDate,
      existingDuration: existingDuration ?? this.existingDuration,
    );
  }
}

class FilterMemoriesEvent extends HomeListEvent {
  final String searchText;
  final List<PeopleItemModel> selectedPeople;
  final List<int> selectedTags;
final List<DateTime> date; // New filter for start and end date
  final int? duration;

  FilterMemoriesEvent({
    required this.searchText,
    required this.selectedPeople,
    required this.selectedTags,
    required this.date,
    required this.duration,
  });

  @override
  List<Object?> get props =>
      [searchText, selectedPeople, selectedTags, date, duration];
}
