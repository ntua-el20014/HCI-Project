import '../../../core/app_export.dart';

/// This class is used in the [photoscarousel_item_widget] screen.
class PhotoscarouselItemModel {
  PhotoscarouselItemModel({
    this.carouselItem,
    this.id,
  }) {
    carouselItem = carouselItem ?? ImageConstant.imgCarouselItem;
    id = id ?? "";
  }

  String? carouselItem;

  String? id;
}
