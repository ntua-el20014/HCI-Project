import 'package:anamnesis/presentation/home_list_screen/models/tag_carousel_model.dart';
import 'bloc/create_memory_bloc.dart';
import 'models/create_memory_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/widgets/app_bar/appbar_leading_image.dart';
import 'package:anamnesis/widgets/app_bar/appbar_subtitle.dart';
import 'package:anamnesis/widgets/app_bar/custom_app_bar.dart';
import 'package:anamnesis/widgets/custom_elevated_button.dart';
import 'package:anamnesis/widgets/custom_floating_text_field.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'models/people_list.dart';
import '../home_list_screen/models/label_item_model.dart';
import '../create_memory_screen/models/image_carousel.dart';
import 'package:path/path.dart' as path;

// Example
final List<PeopleItemModel> peopleList = [
  PeopleItemModel(name: "Alice"),
  PeopleItemModel(name: "Bob"),
  // Add more PeopleItemModel objects as needed
];

final List<LabelItemModel> tags = [
  LabelItemModel(
    label: 'Tag',
    iconPath: ImageConstant.imgUser,
    value: 'lbl_tag',
  ),
  LabelItemModel(
    label: 'Date',
    iconPath: ImageConstant.imgCalendar,
    value: 'lbl_date',
  ),
  LabelItemModel(
    label: 'Duration',
    iconPath: ImageConstant.imgClock,
    value: 'lbl_duration',
  ),
  LabelItemModel(
    label: 'People',
    iconPath: ImageConstant.imgContrast,
    value: 'lbl_people',
  ),
  LabelItemModel(
    label: 'People',
    iconPath: ImageConstant.imgContrast,
    value: 'lbl_people',
  ),
];
class CreateMemoryScreen extends StatefulWidget {
  const CreateMemoryScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<CreateMemoryBloc>(
      create: (context) => CreateMemoryBloc(CreateMemoryState(
        createMemoryModelObj: CreateMemoryModel(),
      ))
        ..add(CreateMemoryInitialEvent()),
      child: CreateMemoryScreen(),
    );
  }

  @override
  _CreateMemoryScreenState createState() => _CreateMemoryScreenState();
}

class _CreateMemoryScreenState extends State<CreateMemoryScreen> {
  @override
Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              SizedBox(height: 10.v),
            _buildTitle1(context),
              SizedBox(height: 15.v),
            _buildInputDatePicker(context),
              SizedBox(height: 20.v),
            _buildLocation(context),
              SizedBox(height: 20.v),
            _buildAddPeople(context, peopleList),
              SizedBox(height: 30.v),
            _buildSelectTags(context),
              SizedBox(height: 30.v),
            _buildPhotos(context),
              SizedBox(height: 30.v),
              _buildJournals(context),
              SizedBox(height: 30.v),
              _buildRecordings(context),
              ],
            ),
        ),
      ),
    );
  }



  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        color: Colors.black,
        imagePath: ImageConstant.imgMegaphone,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 12.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "lbl_new_memory".tr,
      ),
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
                leading: CustomImageView(
                  color: Colors.red,
                  imagePath: ImageConstant.imgEdit,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                ),
                onTap: () {
                  NavigatorService.pushNamed(
                    AppRoutes.homeListScreen,
                  );
                },
                title: Text(
                  'Discard Draft',
                  style: CustomTextStyles.titleSmallRed500,
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: 'save',
              child: ListTile(
                leading: Icon(Icons.save, color: appTheme.deepPurple500),
                onTap: () {
                  NavigatorService.pushNamed(
                    AppRoutes.homeListScreen,
                  );
                },
                title: Text(
                  'Save Draft',
                  style: CustomTextStyles.titleSmallDeeppurple500,
                ),
              ),
            ),
          ],
        ),
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildTitle(BuildContext context) {
    return BlocSelector<CreateMemoryBloc, CreateMemoryState,
        TextEditingController?>(
      selector: (state) => state.titleController,
      builder: (context, titleController) {
        return CustomFloatingTextField(
          controller: titleController,
          labelText: "lbl_title".tr,
          labelStyle: CustomTextStyles.titleLarge20_1,
          hintText: "lbl_title".tr,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildTitle1(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.customBorderTL4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          SizedBox(height: 4.v),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "msg_add_a_title_to_your".tr,
              style: CustomTextStyles.bodyMedium_1,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "lbl_enter_dates".tr,
          style: CustomTextStyles.titleLarge20,
        ),
        SizedBox(height: 8.v),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgIconsToday24px,
              height: 24.adaptSize,
            width: 24.adaptSize,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildDate1(BuildContext context) {
    return BlocSelector<CreateMemoryBloc, CreateMemoryState,
        TextEditingController?>(
      selector: (state) => state.dateController1,
      builder: (context, dateController1) {
        return CustomFloatingTextField(
          width: 137.h,
          controller: dateController1,
          labelText: "lbl_date".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "lbl_date".tr,
          hintStyle: theme.textTheme.bodyLarge!,
          contentPadding: EdgeInsets.fromLTRB(16.h, 19.v, 16.h, 17.v),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildDate2(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12.h,
        top: 8.v,
      ),
      child: BlocSelector<CreateMemoryBloc, CreateMemoryState,
          TextEditingController?>(
        selector: (state) => state.dateController2,
        builder: (context, dateController2) {
          return CustomFloatingTextField(
            width: 137.h,
            controller: dateController2,
            labelText: "lbl_end_date".tr,
            labelStyle: CustomTextStyles.bodyLargeGray800_1,
            hintText: "lbl_end_date".tr,
            contentPadding: EdgeInsets.fromLTRB(16.h, 17.v, 16.h, 19.v),
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildInputDatePicker(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder28,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDate(context),
          SizedBox(height: 9.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDate1(context),
                _buildDate2(context),
              ],
            ),
          ),
          SizedBox(height: 9.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLocation(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.customBorderTL4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocSelector<CreateMemoryBloc, CreateMemoryState,
              TextEditingController?>(
            selector: (state) => state.locationController,
            builder: (context, locationController) {
              return TextField(
                autofocus: false,
                maxLines: 1,
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                controller: locationController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(13.h, 17.v, 13.h, 13.v),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appTheme.blueGray100,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appTheme.blueGray100,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.h),
                    borderSide: BorderSide(
                      color: appTheme.deepPurple500,
                      width: 3,
                    ),
                  ),
                  isDense: true,
                  labelText: "lbl_location".tr,
                  labelStyle: CustomTextStyles.titleLarge20_1,
                  hintText: "lbl_location".tr,
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      // Get current location
                      try {
                        Position position = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high);
                        String locationString =
                            "${position.latitude}, ${position.longitude}";

                        // Update text controller with the current location
                        locationController?.text = locationString;
                      } catch (e) {
                        print("Error getting location: $e");
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.h),
                      child: CustomImageView(
                    color: appTheme.deepPurple500,
                    imagePath: ImageConstant.imgContrastDeepPurple500,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                  ),
                    ),
                  ),
                ),
                textInputAction: TextInputAction.done,
              );
            },
          ),
          SizedBox(height: 4.v),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "msg_search_or_pick_your".tr,
              style: CustomTextStyles.bodyMedium_1,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAddPeople(BuildContext context, List<PeopleItemModel> people) {
    return Container(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "lbl_add_people".tr,
              style: CustomTextStyles.titleLargeBlack900,
            ),
          ),
        SizedBox(height: 13.v),
          PeopleList(people: people),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSelectTags(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "lbl_select_tags".tr,
              style: CustomTextStyles.titleLargeBlack900,
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: _buildTagCarousel(context, tags),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTagCarousel(BuildContext context, List<LabelItemModel> tags) {
    final List<LabelItemModel> selectedTags = [];
    return TagCarousel(
      // Create a list to store the selected tags
      labels: tags,
      selectedLabels: selectedTags, // Pass the selected tags to TagCarousel
      carouselType: CarouselType.TagPicker,
      onLabelTap: (selectedLabel) {
        // Update the selected tags list
        if (!selectedLabel.isSelected) {
          print('Deselected Tag: ${selectedLabel.label}');
          selectedTags.add(selectedLabel);
        } else {
          print('Selected Tag: ${selectedLabel.label}');
          selectedTags.removeWhere((tag) => tag.label == selectedLabel.label);
        }
        setState(() {});
      },
    );
  }

  /// Section Widget
  Widget _buildAdd(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        final picker = ImagePicker();
        PickedFile? pickedFile;

        // Let the user choose between taking a new picture or picking from gallery
        final action = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Add a new picture'),
              content: Text('Choose an option'),
              actions: <Widget>[
                TextButton(
                  child: Text('Take a Picture'),
                  onPressed: () {
                    Navigator.pop(context, 'Take a Picture');
                  },
                ),
                TextButton(
                  child: Text('Pick from Gallery'),
                  onPressed: () {
                    Navigator.pop(context, 'Pick from Gallery');
                  },
                ),
              ],
            );
          },
        );

        if (action == 'Take a Picture') {
          // ignore: deprecated_member_use
          pickedFile = await picker.getImage(source: ImageSource.camera);
        } else if (action == 'Pick from Gallery') {
          // ignore: deprecated_member_use
          pickedFile = await picker.getImage(source: ImageSource.gallery);
  }

        if (pickedFile != null) {
          final appDir = await getApplicationDocumentsDirectory();
          final fileName = path.basename(pickedFile.path);
          final savedImage =
              await File(pickedFile.path).copy('${appDir.path}/$fileName');

          print(savedImage); // Add the image to your album
          // ...
        }
      },
      height: 35.v,
      width: 75.h,
      decoration: null,
      text: "lbl_add".tr,
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgPlus,
          height: 18.adaptSize,
          width: 18.adaptSize,
        ),
      ),
      buttonStyle: CustomButtonStyles.outlineBlackTL17,
      buttonTextStyle: CustomTextStyles.titleSmallDeeppurple500,
    );
  }

  /// Section Widget
  Widget _buildPhotos(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 9.v,
                  bottom: 1.v,
                ),
                child: Text(
                  "msg_photos_from_gallery".tr,
                  style: CustomTextStyles.titleLargeBlack900,
                ),
              ),
              _buildAdd(context),
            ],
          ),
          ImageCarousel(imgList: [
            'assets/images/image_not_found.png',
            'assets/images/image_not_found.png',
            'assets/images/image_not_found.png',
          ])
        ],
      ),
    );
  }

  Widget _buildJournals(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 9.v,
                  bottom: 1.v,
                ),
                child: Text(
                  "Journal Pages".tr,
                  style: CustomTextStyles.titleLargeBlack900,
                ),
              ),
              _buildAdd(context),
            ],
          ),
          ImageCarousel(imgList: [
            'assets/images/image_not_found.png',
            'assets/images/image_not_found.png',
            'assets/images/image_not_found.png',
          ])
        ],
      ),
    );
  }

  Widget _buildRecordings(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 9.v,
                  bottom: 1.v,
                ),
                child: Text(
                  "Recordings".tr,
                  style: CustomTextStyles.titleLargeBlack900,
                ),
              ),
              _buildAdd(context),
            ],
          ),
        ],
      ),
    );
  }
}
