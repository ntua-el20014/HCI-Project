class LabelItemModel {
  LabelItemModel({
    this.label,
    this.iconPath,
    this.value,
  }) {
    label = label ?? "";
    iconPath = iconPath ?? "";
    value = value ?? "";
  }

  String? label;
  String? iconPath;
  String? value;
}
