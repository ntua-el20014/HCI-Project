import 'bloc/memory_journals_journal_bloc.dart';
import 'models/memory_journals_journal_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/widgets/app_bar/appbar_leading_image.dart';
import 'package:anamnesis/widgets/app_bar/appbar_subtitle.dart';
import 'package:anamnesis/widgets/app_bar/appbar_trailing_image.dart';
import 'package:anamnesis/widgets/app_bar/custom_app_bar.dart';

class MemoryJournalsJournalScreen extends StatelessWidget {
  const MemoryJournalsJournalScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<MemoryJournalsJournalBloc>(
      create: (context) => MemoryJournalsJournalBloc(MemoryJournalsJournalState(
        memoryJournalsJournalModelObj: MemoryJournalsJournalModel(),
      ))
        ..add(MemoryJournalsJournalInitialEvent()),
      child: MemoryJournalsJournalScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoryJournalsJournalBloc, MemoryJournalsJournalState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: appTheme.black900,
            appBar: _buildAppBar(context),
            body: CustomImageView(
              imagePath: ImageConstant.imgImg20231007141500,
              height: 621.v,
              width: 360.h,
              margin: EdgeInsets.symmetric(vertical: 65.v),
            ),
          ),
        );
      },
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgMegaphone,
        margin: EdgeInsets.only(
          left: 16.h,
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
            horizontal: 14.h,
            vertical: 12.v,
          ),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }
}
