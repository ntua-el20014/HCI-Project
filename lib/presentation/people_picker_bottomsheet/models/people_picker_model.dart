// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'userprofile_item_model.dart';

/// This class defines the variables used in the [people_picker_bottomsheet],
/// and is typically used to hold data that is passed between different parts of the application.
class PeoplePickerModel extends Equatable {
  PeoplePickerModel({this.userprofileItemList = const []});

  List<UserprofileItemModel> userprofileItemList;

  PeoplePickerModel copyWith(
      {List<UserprofileItemModel>? userprofileItemList}) {
    return PeoplePickerModel(
      userprofileItemList: userprofileItemList ?? this.userprofileItemList,
    );
  }

  @override
  List<Object?> get props => [userprofileItemList];
}
