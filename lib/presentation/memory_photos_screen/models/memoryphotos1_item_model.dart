import '../../../core/app_export.dart';

/// This class is used in the [memoryphotos1_item_widget] screen.
class Memoryphotos1ItemModel {
  Memoryphotos1ItemModel({
    this.image1,
    this.id,
  }) {
    image1 = image1 ?? ImageConstant.imgMikrhMprostinhStampaOmada;
    id = id ?? "";
  }

  String? image1;

  String? id;
}
