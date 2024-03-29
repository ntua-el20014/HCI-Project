import 'package:anamnesis/database/database.dart';

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
                GestureDetector(
                  onTap: () {
                    NavigatorService.pushNamed(
                      AppRoutes.homeListScreen,
                    );
                  },
                  child: Text("lbl_my_memories".tr,
                      style: theme.textTheme.bodyLarge),
                ),
                SizedBox(height: 36.v),
                GestureDetector(
                  onTap: () {
                    NavigatorService.pushNamed(
                      AppRoutes.peopleScreen,
                    );
                  },
                  child:
                      Text("People & Tags", style: theme.textTheme.bodyLarge),
                ),
                SizedBox(height: 35.v),
                GestureDetector(
                  onTap: () => showAddPeopleDialog(context),
                  child: Text("+ Add new person".tr,
                      style: theme.textTheme.bodyLarge),
                ),
                SizedBox(height: 35.v),
                GestureDetector(
                  onTap: () => showAddTagDialog(context),
                  child: Text("msg_create_new_tag".tr,
                      style: theme.textTheme.bodyLarge),
                ),
                SizedBox(height: 36.v),
                GestureDetector(
                  onTap: () {
                    NavigatorService.pushNamed(
                      AppRoutes.settingsScreen,
                    );
                  },
                  child:
                      Text("lbl_settings".tr, style: theme.textTheme.bodyLarge),
                ),
                SizedBox(height: 35.v),
                GestureDetector(
                  onTap: () {
                    NavigatorService.pushNamed(
                      AppRoutes.aboutScreen,
                    );
                  },
                  child: Text("lbl_about".tr, style: theme.textTheme.bodyLarge),
                ),
                SizedBox(height: 5.v),
                Spacer(), // Pushes the following widgets to the bottom

                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
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

void showAddTagDialog(BuildContext context) {
  final TextEditingController _textController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ), //this right here
        child: Container(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your tag',
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Add'),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        DatabaseHelper dbHelp = DatabaseHelper();
                        await dbHelp.insertTag(label: _textController.text);
                        NavigatorService.pushNamed(
                          AppRoutes.peopleScreen,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showAddPeopleDialog(BuildContext context) {
  final TextEditingController _textController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ), //this right here
        child: Container(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Add a new person',
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Add'),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        DatabaseHelper dbHelp = DatabaseHelper();
                        await dbHelp.insertPerson(name: _textController.text);
                        NavigatorService.pushNamed(
                          AppRoutes.peopleScreen,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
