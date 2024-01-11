import 'bloc/side_menu_bloc.dart';
import 'models/side_menu_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
class SideMenuScreen extends StatelessWidget {
  const SideMenuScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<SideMenuBloc>(
        create: (context) =>
            SideMenuBloc(SideMenuState(sideMenuModelObj: SideMenuModel()))
              ..add(SideMenuInitialEvent()),
        child: SideMenuScreen());
  }

  @override
Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(color: Colors.transparent),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 27.v),
            decoration: AppDecoration.outlineBlack900
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("lbl_my_memories".tr, style: theme.textTheme.bodyLarge),
                SizedBox(height: 36.v),
                Text("lbl_people".tr, style: theme.textTheme.bodyLarge),
                SizedBox(height: 35.v),
                Text("lbl_drafts".tr, style: theme.textTheme.bodyLarge),
                SizedBox(height: 38.v),
                Text("msg_create_new_tag".tr, style: theme.textTheme.bodyLarge),
                SizedBox(height: 36.v),
                Text("lbl_insights".tr, style: theme.textTheme.bodyLarge),
                SizedBox(height: 35.v),
                Text("lbl_trash".tr, style: theme.textTheme.bodyLarge),
                SizedBox(height: 38.v),
                Text("lbl_settings".tr, style: theme.textTheme.bodyLarge),
                SizedBox(height: 35.v),
                Text("lbl_about".tr, style: theme.textTheme.bodyLarge),
                SizedBox(height: 5.v)
              ],
            ),
          ),
        ),
      ],
    );
  }



  /// Navigates to the previous screen.
  onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }
}
