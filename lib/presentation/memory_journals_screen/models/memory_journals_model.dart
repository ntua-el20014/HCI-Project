// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'memoryjournals_item_model.dart';

/// This class defines the variables used in the [memory_journals_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class MemoryJournalsModel extends Equatable {
  MemoryJournalsModel({this.memoryjournalsItemList = const []});

  List<MemoryjournalsItemModel> memoryjournalsItemList;

  MemoryJournalsModel copyWith(
      {List<MemoryjournalsItemModel>? memoryjournalsItemList}) {
    return MemoryJournalsModel(
      memoryjournalsItemList:
          memoryjournalsItemList ?? this.memoryjournalsItemList,
    );
  }

  @override
  List<Object?> get props => [memoryjournalsItemList];
}
