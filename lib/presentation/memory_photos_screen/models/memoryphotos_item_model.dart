import 'memoryphotos1_item_model.dart';
import '../../../core/app_export.dart';

/// This class is used in the [memoryphotos_item_widget] screen.
class MemoryphotosItemModel {
  MemoryphotosItemModel({
    this.dayText,
    this.memoryphotos1ItemList,
    this.id,
  }) {
    dayText = dayText ?? "Day DD/MM/YY";
    memoryphotos1ItemList = memoryphotos1ItemList ??
        [
          Memoryphotos1ItemModel(
              image1: ImageConstant.imgMikrhMprostinhStampaOmada),
          Memoryphotos1ItemModel(image1: ImageConstant.imgPeriodikosPinakas),
          Memoryphotos1ItemModel(image1: ImageConstant.imgThumbnail),
          Memoryphotos1ItemModel(
              image1: ImageConstant.imgPeriodikosPinakas134x121),
          Memoryphotos1ItemModel(
              image1: ImageConstant.imgMikrhMprostinhStampaOmada134x119),
          Memoryphotos1ItemModel(
              image1: ImageConstant.imgPeriodikosPinakas134x120)
        ];
    id = id ?? "";
  }

  String? dayText;

  List<Memoryphotos1ItemModel>? memoryphotos1ItemList;

  String? id;
}
