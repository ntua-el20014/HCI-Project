class LabelItemModel {
  LabelItemModel({
    this.label,
    this.iconPath,
    this.value,
    this.isSelected = false,
  }) {
    label = label ?? "";
    iconPath = iconPath ?? "";
    value = value ?? "";
  }

  String? label;
  String? iconPath;
  String? value;
  bool isSelected;
}

enum CarouselType {
  TagPicker,
  FilterEditor,
}
