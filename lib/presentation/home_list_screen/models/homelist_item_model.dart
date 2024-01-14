import '../../../core/app_export.dart';

/// This class is used in the [homelist_item_widget] screen.
class HomelistItemModel {
  HomelistItemModel({
    this.date,
    this.overlineText,
    this.headlineText,
    this.supportingText,
    this.id,
  }) {
    date = date ?? ImageConstant.imgThumbnail;
    overlineText = overlineText ?? "dd / mm / yyyy";
    headlineText = headlineText ?? "Memory Title";
    supportingText = supportingText ??
        "Supporting line text lorem ipsum dolor sit amet, consectetur.";
    id = id ?? 1;
  }

  String? date;

  String? overlineText;

  String? headlineText;

  String? supportingText;

  int? id;
}
