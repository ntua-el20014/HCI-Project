/// This class is used in the [userprofile_item_widget] screen.
class UserprofileItemModel {
  UserprofileItemModel({
    this.headlineText,
    this.id,
  }) {
    headlineText = headlineText ?? "Person";
    id = id ?? "";
  }


  String? headlineText;

  String? id;
}
