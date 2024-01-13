class LabelItemModel {
  LabelItemModel({
    this.label,
    this.iconPath,
    this.value,
    this.isSelected = false,
    this.id,
  }) {
    label = label ?? "";
    iconPath = iconPath ?? "";
    value = value ?? "";
  }
  String? label;
  String? iconPath;
  String? value;
  bool isSelected;
  int? id;
}

enum CarouselType {
  TagPicker,
  FilterEditor,
}
