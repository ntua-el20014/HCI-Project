import 'label_item_model.dart';

class LabelListModel {
  LabelListModel({
    this.labels,
  }) {
    labels = labels ?? [];
  }

  List<LabelItemModel>? labels;
}
