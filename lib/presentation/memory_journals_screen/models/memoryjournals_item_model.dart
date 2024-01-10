
/// This class is used in the [memoryjournals_item_widget] screen.
class MemoryjournalsItemModel {
  MemoryjournalsItemModel({
    this.dynamicText,
    this.id,
  }) {
    dynamicText = dynamicText ?? "Journal DD/MM/YY";
    id = id ?? "";
  }

  String? dynamicText;

  String? id;
}
