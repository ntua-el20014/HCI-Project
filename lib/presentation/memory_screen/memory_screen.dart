import 'package:anamnesis/database/database.dart';
import 'package:anamnesis/presentation/memory_screen/widgets/audio_player_widget.dart';

import 'bloc/memory_bloc.dart';
import 'models/memory_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/widgets/app_bar/appbar_leading_image.dart';
import 'package:anamnesis/widgets/app_bar/appbar_subtitle.dart';
import 'package:anamnesis/widgets/app_bar/custom_app_bar.dart';
import 'package:anamnesis/widgets/custom_switch.dart';

class MemoryScreen extends StatelessWidget {
  final int memId;

  const MemoryScreen({Key? key, required this.memId}) : super(key: key);

  static Widget builder(BuildContext context) {
    final memId = ModalRoute.of(context)?.settings.arguments as int;
    return BlocProvider<MemoryBloc>(
        create: (context) => MemoryBloc(
            memId, MemoryState(memoryModelObj: MemoryModel(id: memId)))
          ..add(MemoryInitialEvent(memId)),
        child: MemoryScreen(memId: memId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MemoryBloc, MemoryState, MemoryModel>(
        selector: (state) => state.memoryModelObj!,
        builder: (context, memoryModelObj) {
          if (memoryModelObj.loaded == false)
            return Container(
              color: Colors.white,
            );
          return SafeArea(
            child: Scaffold(
              appBar: _buildAppBar(context, memoryModelObj),
              body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                          imagePath: memoryModelObj.thumbnail,
                          height: 197.v,
                          width: 360.h),
                      SizedBox(height: 18.v),
                      Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text(memoryModelObj.title,
                              style: theme.textTheme.titleMedium)),
                      SizedBox(height: 2.v),
                      Container(
                          width: 215.h,
                          margin: EdgeInsets.only(left: 10.h),
                          child: Text(
                              "${memoryModelObj.start_date}  to ${memoryModelObj.start_date},\n 📍${memoryModelObj.location}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(height: 1.43))),
                      SizedBox(height: 16.v),
                      Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text("People",
                              style: theme.textTheme.titleMedium)),
                      SizedBox(height: 4.v),
                      Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text(_getPeople(memoryModelObj),
                              style: theme.textTheme.bodyMedium)),
                      SizedBox(height: 18.v),
                      _buildTags(context, memoryModelObj),
                      SizedBox(height: 18.v),
                      _buildPhotos(context),
                      SizedBox(height: 17.v),
                      Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text("lbl_your_journey".tr,
                              style: CustomTextStyles.titleLargeBold)),
                      Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text("msg_total_distance".tr,
                              style: CustomTextStyles.bodyLargeGray800_2)),
                      SizedBox(height: 16.v),
                      _buildTrackSwitch(context),
                      SizedBox(height: 15.v),
                      CustomImageView(
                          imagePath: ImageConstant.imgMap,
                          height: 163.v,
                          width: 240.h,
                          radius: BorderRadius.circular(19.h),
                          alignment: Alignment.center,
                          onTap: () {
                            onTapImgMap(context);
                          }),
                      SizedBox(height: 15.v),
                      _buildJournal(context),
                      _buildJournalCarousel(context),
                      SizedBox(height: 15.v),
                      _buildRecordings(context),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(
      BuildContext context, MemoryModel memoryModelObj) {
    return CustomAppBar(
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            color: Colors.black,
            imagePath: ImageConstant.imgMegaphone,
            margin: EdgeInsets.only(left: 16.h, top: 12.v, bottom: 12.v)),
        centerTitle: true,
        title: AppbarSubtitle(text: memoryModelObj.title),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (String result) {
              // Handle menu item selection
              print('Selected: $result');
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'discard',
                child: ListTile(
                  leading: Icon(Icons.delete, color: appTheme.red500),
                  onTap: () {
                    _showDeleteDialogue(context, memoryModelObj);
                  },
                  title: Text(
                    'Delete memory',
                    style: CustomTextStyles.titleSmallRed500,
                  ),
                ),
              ),
            ],
          ),
        ],
        styleType: Style.bgShadow);
  }

  void _showDeleteDialogue(BuildContext context, MemoryModel memoryModelObj) {
    print("Delete dialogue");
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Are you sure?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      "This action will delete your memory, along with its photos, journal entries and recordings."),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: Text('Delete memory'),
                        onPressed: () async {
                          DatabaseHelper dbHelp = DatabaseHelper();
                          await dbHelp.deleteMemory(memoryModelObj.id);
                          NavigatorService.pushNamed(
                            AppRoutes.homeListScreen,
                          );
                        },
                      ),
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Add your add button logic here
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

  String _getPeople(MemoryModel memoryModelObj) {
    String people = '';
    for (int i = 0; i < memoryModelObj.people.length; i++) {
      people += memoryModelObj.people[i]["name"] + ', ';
    }
    if (people == '')
      people = "Just you";
    else
      people = people.substring(0, people.length - 2); //remove last comma
    return people;
  }

  Widget _buildTags(BuildContext context, MemoryModel memoryModelObj) {
    List<Widget> children = [];
    for (int i = 0; i < memoryModelObj.tags.length; i++) {
      children.add(
        ElevatedButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              memoryModelObj.tags[i]["label"],
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(left: 10.h),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: children,
      ),
    );
  }

  /// Section Widget
  Widget _buildPhotos(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 9.v),
            decoration: AppDecoration.fillWhiteA,
            child: Text("Photos", style: CustomTextStyles.titleLargeBold)),
        Container(
            height: 198.v,
            padding: EdgeInsets.symmetric(vertical: 13.v),
            decoration: AppDecoration.fillWhiteA,
            child: BlocSelector<MemoryBloc, MemoryState, MemoryModel?>(
                selector: (state) => state.memoryModelObj,
                builder: (context, memoryModelObj) {
                  if (memoryModelObj?.images.length == 0) {
                    return Center(child: Text("This memory has no photos"));
                  }
                  return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 4.h);
                      },
                      itemCount: memoryModelObj?.images.length ?? 0,
                      itemBuilder: (context, index) {
                        String? imagePath = memoryModelObj?.images[index];
                        return Container(
                          padding: EdgeInsets.only(left: 5.h, right: 5.h),
                          child: CustomImageView(
                            imagePath: imagePath,
                          ),
                        );
                      });
                })),
      ],
    );
  }

  /// Section Widget
  Widget _buildTrackSwitch(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 7.v, bottom: 5.v),
                      child: Text("msg_track_my_location".tr,
                          style: CustomTextStyles.bodyLargeGray800)),
                  BlocSelector<MemoryBloc, MemoryState, bool?>(
                      selector: (state) => state.isSelectedSwitch,
                      builder: (context, isSelectedSwitch) {
                        return CustomSwitch(
                            value: isSelectedSwitch,
                            onChange: (value) {
                              context
                                  .read<MemoryBloc>()
                                  .add(ChangeSwitchEvent(value: value));
                            });
                      })
                ])));
  }

  /// Section Widget
  Widget _buildJournal(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 9.v),
        decoration: AppDecoration.fillWhiteA,
        child: Column(children: [
          SizedBox(height: 7.v),
          Text("lbl_journal".tr, style: CustomTextStyles.titleLargeBold)
        ]));
  }

  /// Section Widget
  Widget _buildJournalCarousel(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 13.v),
        decoration: AppDecoration.fillWhiteA,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CustomImageView(
              imagePath: ImageConstant.imgCarouselItem172x210,
              height: 172.v,
              width: 210.h,
              radius: BorderRadius.circular(28.h),
              margin: EdgeInsets.only(left: 14.h)),
          CustomImageView(
              imagePath: ImageConstant.imgCarouselItem1,
              height: 172.v,
              width: 122.h,
              radius: BorderRadius.circular(28.h))
        ]));
  }

  /// Section Widget
  Widget _buildRecordings(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16.h, bottom: 9.v),
              decoration: AppDecoration.fillWhiteA,
              child: Text("Recordings", style: CustomTextStyles.titleLargeBold),
            ),
          ],
        ),
        BlocSelector<MemoryBloc, MemoryState, MemoryModel?>(
            selector: (state) => state.memoryModelObj,
            builder: (context, memoryModelObj) {
              if (memoryModelObj?.recordings.length == 0) {
                return Center(child: Text("This memory has no recordings"));
              }
              return ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: memoryModelObj?.recordings.length ?? 0,
                separatorBuilder: ((context, index) {
                  return SizedBox(height: 2.v);
                }),
                itemBuilder: (context, index) {
                  return AudioPlayerWidget(
                    audioPath: memoryModelObj?.recordings[index],
                    isAsset: memoryModelObj?.recordings[index]
                            .startsWith('assets/') ??
                        false,
                  );
                },
              );
            })
      ],
    );
  }

  /// Navigates to the memoryMapScreen when the action is triggered.
  onTapImgMap(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.memoryMapScreen,
    );
  }
}
