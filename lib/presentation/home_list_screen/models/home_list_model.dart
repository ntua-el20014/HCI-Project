// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'homelist_item_model.dart';

/// This class defines the variables used in the [home_list_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class HomeListModel extends Equatable {
  HomeListModel({this.homelistItemList = const []});

  List<HomelistItemModel> homelistItemList;

  HomeListModel copyWith({List<HomelistItemModel>? homelistItemList}) {
    return HomeListModel(
      homelistItemList: homelistItemList ?? this.homelistItemList,
    );
  }

  @override
  List<Object?> get props => [homelistItemList];
}
