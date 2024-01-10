import '../../../core/app_export.dart';

/// This class is used in the [homelist_item_widget] screen.
class HomelistItemModel {
  HomelistItemModel({
    this.date,
    this.overlineText,
    this.headlineText,
    this.smallFAB,
    this.supportingText,
    this.id,
  }) {
    date = date ?? ImageConstant.imgThumbnail;
    overlineText = overlineText ?? "dd / mm / yyyy";
    headlineText = headlineText ?? "Memory Title";
    smallFAB = smallFAB ?? ImageConstant.imgSmallFab;
    supportingText = supportingText ??
        "Supporting line text lorem ipsum dolor sit amet, consectetur.";
    id = id ?? "";
  }

  String? date;

  String? overlineText;

  String? headlineText;

  String? smallFAB;

  String? supportingText;

  String? id;
}
