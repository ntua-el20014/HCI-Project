
/// This class is used in the [userprofile1_item_widget] screen.
class Userprofile1ItemModel {
  Userprofile1ItemModel({
    this.dateTimeText,
    this.durationText,
    this.id,
  }) {
    dateTimeText = dateTimeText ?? "DD/MM HH:MM ";
    durationText = durationText ?? "Duration";
    id = id ?? "";
  }

  String? dateTimeText;

  String? durationText;

  String? id;
}
