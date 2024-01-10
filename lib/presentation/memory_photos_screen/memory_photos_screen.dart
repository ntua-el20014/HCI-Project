import '../memory_photos_screen/widgets/memoryphotos_item_widget.dart';
import 'bloc/memory_photos_bloc.dart';
import 'models/memory_photos_model.dart';
import 'models/memoryphotos_item_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/widgets/app_bar/appbar_leading_image.dart';
import 'package:anamnesis/widgets/app_bar/appbar_subtitle.dart';
import 'package:anamnesis/widgets/app_bar/appbar_trailing_image.dart';
import 'package:anamnesis/widgets/app_bar/custom_app_bar.dart';

class MemoryPhotosScreen extends StatelessWidget {
  const MemoryPhotosScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<MemoryPhotosBloc>(
      create: (context) => MemoryPhotosBloc(MemoryPhotosState(
        memoryPhotosModelObj: MemoryPhotosModel(),
      ))
        ..add(MemoryPhotosInitialEvent()),
      child: MemoryPhotosScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6.v),
              Text(
                "lbl_photos".tr,
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: 18.v),
              _buildMemoryPhotos(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 38.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgMegaphone,
        margin: EdgeInsets.only(
          left: 14.h,
          top: 12.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "lbl_memory_title".tr,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgClose,
          margin: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 12.v,
          ),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  Widget _buildMemoryPhotos(BuildContext context) {
    return Expanded(
      child:
          BlocSelector<MemoryPhotosBloc, MemoryPhotosState, MemoryPhotosModel?>(
        selector: (state) => state.memoryPhotosModelObj,
        builder: (context, memoryPhotosModelObj) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                height: 20.v,
              );
            },
            itemCount: memoryPhotosModelObj?.memoryphotosItemList.length ?? 0,
            itemBuilder: (context, index) {
              MemoryphotosItemModel model =
                  memoryPhotosModelObj?.memoryphotosItemList[index] ??
                      MemoryphotosItemModel();
              return MemoryphotosItemWidget(
                model,
              );
            },
          );
        },
      ),
    );
  }
}
