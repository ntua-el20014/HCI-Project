// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'photoscarousel_item_model.dart';
import 'userprofile1_item_model.dart';

/// This class defines the variables used in the [memory_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class MemoryModel extends Equatable {
  MemoryModel({
    required this.id,
    this.title = "Untitled Memory",
    this.thumbnail = "assets/images/image_not_found.png",
    this.start_date = "No start date",
    this.end_date = "No end date",
    this.location = "No location",
    this.images = const [],
    this.recordings = const [],
    this.tags = const [],
    this.people = const [],
    this.photoscarouselItemList = const [],
    this.userprofile1ItemList = const [],
    this.loaded = false,
  });

  List<Userprofile1ItemModel> userprofile1ItemList;
  List<PhotoscarouselItemModel> photoscarouselItemList;

  int id;
  String title;
  String thumbnail;
  String start_date;
  String end_date;
  String location;
  List<dynamic> images;
  List<dynamic> recordings;
  List<Map<String, dynamic>> tags;
  List<Map<String, dynamic>> people;
  bool loaded;

  MemoryModel copyWith({
    List<PhotoscarouselItemModel>? photoscarouselItemList,
    List<Userprofile1ItemModel>? userprofile1ItemList,
    int? id,
    String? title,
    String? thumbnail,
    String? start_date,
    String? end_date,
    String? location,
    List<dynamic>? images,
    List<dynamic>? recordings,
    List<Map<String, dynamic>>? tags,
    List<Map<String, dynamic>>? people,
    bool? loaded,
  }) {
    print("Starting copyWith...");
    return MemoryModel(
      photoscarouselItemList:
          photoscarouselItemList ?? this.photoscarouselItemList,
      userprofile1ItemList: userprofile1ItemList ?? this.userprofile1ItemList,
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      location: location ?? this.location,
      images: images ?? this.images,
      recordings: recordings ?? this.recordings,
      tags: tags ?? this.tags,
      people: people ?? this.people,
      loaded: loaded ?? this.loaded,
    );
  }

  @override
  List<Object?> get props => [
        photoscarouselItemList,
        // userprofile1ItemList,
      ];
}
