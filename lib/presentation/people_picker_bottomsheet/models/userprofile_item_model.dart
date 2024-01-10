import '../../../core/app_export.dart';

/// This class is used in the [userprofile_item_widget] screen.
class UserprofileItemModel {
  UserprofileItemModel({
    this.userImage,
    this.headlineText,
    this.id,
  }) {
    userImage = userImage ?? ImageConstant.imgLock;
    headlineText = headlineText ?? "Person";
    id = id ?? "";
  }

  String? userImage;

  String? headlineText;

  String? id;
}
