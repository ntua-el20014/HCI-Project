import '../people_picker_bottomsheet/widgets/userprofile_item_widget.dart';
import 'bloc/people_picker_bloc.dart';
import 'models/people_picker_model.dart';
import 'models/userprofile_item_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';

// ignore_for_file: must_be_immutable
class PeoplePickerBottomsheet extends StatelessWidget {
  const PeoplePickerBottomsheet({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<PeoplePickerBloc>(
      create: (context) => PeoplePickerBloc(PeoplePickerState(
        peoplePickerModelObj: PeoplePickerModel(),
      ))
        ..add(PeoplePickerInitialEvent()),
      child: PeoplePickerBottomsheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 363.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.customBorderTL28,
      ),
      child: Column(
        children: [
          Opacity(
            opacity: 0.4,
            child: Container(
              height: 4.v,
              width: 32.h,
              decoration: BoxDecoration(
                color: appTheme.gray600.withOpacity(0.49),
                borderRadius: BorderRadius.circular(
                  2.h,
                ),
              ),
            ),
          ),
          SizedBox(height: 17.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 19.h),
              child: Text(
                "lbl_select_people".tr,
                style: CustomTextStyles.titleLargeBold,
              ),
            ),
          ),
          SizedBox(height: 6.v),
          _buildUserProfile(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfile(BuildContext context) {
    return Expanded(
      child:
          BlocSelector<PeoplePickerBloc, PeoplePickerState, PeoplePickerModel?>(
        selector: (state) => state.peoplePickerModelObj,
        builder: (context, peoplePickerModelObj) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                height: 1.v,
              );
            },
            itemCount: peoplePickerModelObj?.userprofileItemList.length ?? 0,
            itemBuilder: (context, index) {
              UserprofileItemModel model =
                  peoplePickerModelObj?.userprofileItemList[index] ??
                      UserprofileItemModel();
              return UserprofileItemWidget(
                model,
              );
            },
          );
        },
      ),
    );
  }
}
