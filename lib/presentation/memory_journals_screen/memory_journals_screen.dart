import '../memory_journals_screen/widgets/memoryjournals_item_widget.dart';
import 'bloc/memory_journals_bloc.dart';
import 'models/memory_journals_model.dart';
import 'models/memoryjournals_item_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/widgets/app_bar/appbar_leading_image.dart';
import 'package:anamnesis/widgets/app_bar/appbar_subtitle.dart';
import 'package:anamnesis/widgets/app_bar/appbar_trailing_image.dart';
import 'package:anamnesis/widgets/app_bar/custom_app_bar.dart';

class MemoryJournalsScreen extends StatelessWidget {
  const MemoryJournalsScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<MemoryJournalsBloc>(
        create: (context) => MemoryJournalsBloc(
            MemoryJournalsState(memoryJournalsModelObj: MemoryJournalsModel()))
          ..add(MemoryJournalsInitialEvent()),
        child: MemoryJournalsScreen());
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
                      Text("lbl_journal".tr,
                          style: theme.textTheme.headlineSmall),
                      SizedBox(height: 18.v),
                      _buildMemoryJournals(context)
                    ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgMegaphone,
            margin: EdgeInsets.only(left: 16.h, top: 12.v, bottom: 12.v)),
        centerTitle: true,
        title: AppbarSubtitle(text: "lbl_memory_title".tr),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgClose,
              margin: EdgeInsets.symmetric(horizontal: 14.h, vertical: 12.v))
        ],
        styleType: Style.bgShadow);
  }

  /// Section Widget
  Widget _buildMemoryJournals(BuildContext context) {
    return Expanded(
        child: BlocSelector<MemoryJournalsBloc, MemoryJournalsState,
                MemoryJournalsModel?>(
            selector: (state) => state.memoryJournalsModelObj,
            builder: (context, memoryJournalsModelObj) {
              return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20.v);
                  },
                  itemCount:
                      memoryJournalsModelObj?.memoryjournalsItemList.length ??
                          0,
                  itemBuilder: (context, index) {
                    MemoryjournalsItemModel model =
                        memoryJournalsModelObj?.memoryjournalsItemList[index] ??
                            MemoryjournalsItemModel();
                    return MemoryjournalsItemWidget(model,
                        onTapImgDynamicImage1: () {
                      onTapImgDynamicImage1(context);
                    });
                  });
            }));
  }

  /// Navigates to the memoryJournalsJournalScreen when the action is triggered.
  onTapImgDynamicImage1(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.memoryJournalsJournalScreen,
    );
  }
}
