import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';

class PeopleItemModel {
  PeopleItemModel({
    this.name,
    this.isSelected,
    this.id,
  }) {
    name = name ?? "";
    isSelected = isSelected ?? false;
  }

  String? name;
  bool? isSelected;
  int? id;
}

class PeopleList extends StatefulWidget {
  final List<PeopleItemModel> people;

  PeopleList({required this.people});

  @override
  _PeopleListState createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var person in widget.people)
            InkWell(
              onTap: () {
                setState(() {
                  person.isSelected = !person.isSelected!;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.h,
                  vertical: 7.v,
                ),
                decoration: AppDecoration.fillGray,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLock,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      margin: EdgeInsets.only(bottom: 1.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16.h,
                        bottom: 4.v,
                      ),
                      child: Text(
                        person.name!,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      margin: EdgeInsets.only(bottom: 1.v),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 18.adaptSize,
                              width: 18.adaptSize,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.h,
                                  color: appTheme.black900,
                                ),
                                color: appTheme.gray50,
                                borderRadius: BorderRadius.circular(
                                  2.h,
                                ),
                              ),
                            ),
                          ),
                          person.isSelected == true
                              ? CustomImageView(
                                  imagePath: ImageConstant.imgIconsCheckSmall,
                                  height: 24.adaptSize,
                                  width: 24.adaptSize,
                                  alignment: Alignment.center,
                                )
                              : Container(
                                  color: Colors.transparent,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
