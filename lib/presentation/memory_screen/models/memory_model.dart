// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'photoscarousel_item_model.dart';
import 'userprofile1_item_model.dart';

/// This class defines the variables used in the [memory_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class MemoryModel extends Equatable {
  MemoryModel({
    this.photoscarouselItemList = const [],
    this.userprofile1ItemList = const [],
  });

  List<PhotoscarouselItemModel> photoscarouselItemList;

  List<Userprofile1ItemModel> userprofile1ItemList;

  MemoryModel copyWith({
    List<PhotoscarouselItemModel>? photoscarouselItemList,
    List<Userprofile1ItemModel>? userprofile1ItemList,
  }) {
    return MemoryModel(
      photoscarouselItemList:
          photoscarouselItemList ?? this.photoscarouselItemList,
      userprofile1ItemList: userprofile1ItemList ?? this.userprofile1ItemList,
    );
  }

  @override
  List<Object?> get props => [photoscarouselItemList, userprofile1ItemList];
}
