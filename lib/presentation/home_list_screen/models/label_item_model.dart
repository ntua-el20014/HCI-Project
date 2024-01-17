class LabelItemModel {
  LabelItemModel({
    this.label,
    this.iconPath,
    this.value,
    this.isSelected = false,
    this.id,
    this.memoryCount,
  }) {
    label = label ?? "";
    iconPath = iconPath ?? "";
    value = value ?? "";
    memoryCount = memoryCount ?? 0;
  }
  String? label;
  String? iconPath;
  String? value;
  bool isSelected;
  int? id;
  int? memoryCount;
}

enum CarouselType {
  TagPicker,
  FilterEditor,
}
