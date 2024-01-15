import 'bloc/date_picker_bloc.dart';
import 'models/date_picker_model.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';

class DatePickerBottomsheet extends StatelessWidget {
  const DatePickerBottomsheet({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<DatePickerBloc>(
      create: (context) => DatePickerBloc(
        DatePickerState(datePickerModelObj: DatePickerModel()),
      )..add(DatePickerInitialEvent()),
      child: DatePickerBottomsheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.h,
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
                borderRadius: BorderRadius.circular(2.h),
              ),
            ),
          ),
          SizedBox(height: 16.v),
          Expanded(
            child: SizedBox(
              width: 327.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: AppDecoration.fillWhiteA,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildHeader(context),
                          SizedBox(height: 13.v),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("lbl_s".tr,
                                    style: theme.textTheme.bodyLarge),
                                Text("lbl_m".tr,
                                    style: theme.textTheme.bodyLarge),
                                Text("lbl_t".tr,
                                    style: theme.textTheme.bodyLarge),
                                Text("lbl_w".tr,
                                    style: theme.textTheme.bodyLarge),
                                Text("lbl_t".tr,
                                    style: theme.textTheme.bodyLarge),
                                Text("lbl_f".tr,
                                    style: theme.textTheme.bodyLarge),
                                Text("lbl_s".tr,
                                    style: theme.textTheme.bodyLarge),
                              ],
                            ),
                          ),
                          SizedBox(height: 13.v),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: _buildCalendar(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(12.h, 14.v, 12.h, 13.v),
        decoration: AppDecoration.outlineBlueGray,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 9.v),
          Padding(
              padding: EdgeInsets.only(right: 12.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgClose,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        onTap: () {
                          onTapImgClose(context);
                        }),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 3.v),
                        child: Text("lbl_save".tr,
                            style: CustomTextStyles.titleSmallDeeppurple500))
                  ])),
          SizedBox(height: 14.v),
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.only(left: 52.h, right: 12.h),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("lbl_range".tr,
                              style: CustomTextStyles.titleSmallGray800),
                          SizedBox(height: 11.v),
                          Text("lbl_aug_17_aug_23".tr,
                              style: theme.textTheme.titleLarge)
                        ]),
                    CustomImageView(
                        imagePath: ImageConstant.imgEdit,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        margin:
                            EdgeInsets.only(left: 50.h, top: 21.v, bottom: 9.v))
                  ])))
        ]));
  }

  Widget _buildCalendar(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: BlocBuilder<DatePickerBloc, DatePickerState>(
        builder: (context, state) {
          return SizedBox(
            height: 245.v,
            width: 327.h,
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.multi,
                firstDate: DateTime(DateTime.now().year - 5),
                lastDate: DateTime(DateTime.now().year + 5),
                firstDayOfWeek: 0,
                selectedDayTextStyle: TextStyle(
                  color: Color(0XFF6750A4),
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                dayTextStyle: TextStyle(
                  color: appTheme.gray90001,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                dayBorderRadius: BorderRadius.circular(20.h),
              ),
              value: state.selectedDatesFromCalendar1 ?? [],
              onValueChanged: (dates) {
                state.selectedDatesFromCalendar1 = dates;
              },
            ),
          );
        },
      ),
    );
  }

  onTapImgClose(BuildContext context) {
    NavigatorService.goBack();
  }
}
