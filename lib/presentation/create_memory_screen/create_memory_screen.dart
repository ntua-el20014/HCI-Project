import 'package:anamnesis/database/database.dart';
import 'package:anamnesis/presentation/create_memory_screen/models/audio_player_controller.dart';
import 'package:anamnesis/presentation/create_memory_screen/models/audio_visualizer.dart';
import 'package:anamnesis/presentation/create_memory_screen/models/record_cubit.dart';
import 'package:anamnesis/presentation/create_memory_screen/models/record_stat.dart'
    as mem;
import 'package:anamnesis/presentation/create_memory_screen/widgets/create_memory_button.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:anamnesis/presentation/memory_screen/widgets/audio_player_widget.dart';
import 'package:permission_handler/permission_handler.dart';
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
import 'models/people_list.dart';
import '../home_list_screen/models/label_item_model.dart';
import '../create_memory_screen/models/image_carousel.dart';
import 'package:path/path.dart' as path;

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
  final GlobalKey<CreateMemoryButtonState> createMemoryButtonKey =
      GlobalKey<CreateMemoryButtonState>();
  late String currentTitle = ""; // Store the latest text value
  final ValueNotifier<String> titleNotifier = ValueNotifier<String>('');
  TextEditingController locationController = TextEditingController();
  List<String> recordingPaths = [];
  final ValueNotifier<List<String>> recordingsNotifier =
      ValueNotifier<List<String>>([]);
  LatLng? myLocation;
  List<String> imgList = [];
  final ValueNotifier<List<String>> imgListNotifier =
      ValueNotifier<List<String>>([]);
  List<String> journalList = [];
  final ValueNotifier<List<String>> journalNotifier =
      ValueNotifier<List<String>>([]);
  final List<LabelItemModel> selectedTags = [];
  List<PeopleItemModel> mySelectedPeople = [];
  File? thumbnailImage;
  DateTime? startDate;
  DateTime? endDate;
  final ValueNotifier<String> datesNotifier = ValueNotifier<String>("");
  final ValueNotifier<File?> thumbnailNotifier = ValueNotifier<File?>(null);
  AudioPlayerController audioPlayerController = AudioPlayerController();

  Future<Map<String, dynamic>> _getFutureData() async {
    print("Getting future data...");
    Map<String, dynamic> futureData = {"tags": [], "people": []};

    DatabaseHelper dbHelper = DatabaseHelper();

    // Create tags list
    List<Map<String, dynamic>> tags = await dbHelper.getTags();
    List<LabelItemModel> tagsList = [];
    for (Map<String, dynamic> tag in tags) {
      tagsList.add(LabelItemModel(
        label: tag["label"],
        iconPath: ImageConstant.imgUser,
        id: tag["id"],
      ));
    }
    futureData["tags"] = tagsList;

    // Create people list
    List<Map<String, dynamic>> people = await dbHelper.getPeople();
    List<PeopleItemModel> peopleList = [];
    for (Map<String, dynamic> person in people) {
      peopleList.add(PeopleItemModel(
        name: person["name"],
        id: person["id"],
      ));
    }
    futureData["people"] = peopleList;

    return futureData;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<Map<String, dynamic>>(
          future: _getFutureData(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Show loading spinner while waiting for location
            } else if (snapshot.hasError) {
              return Text(
                  'Error: ${snapshot.error}'); // Show error message if an error occurred
            }
            Map<String, dynamic> data =
                snapshot.data ?? {"tags": [], "people": []};
            print("Data: ${data['people']}");
            return Scaffold(
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
                    _buildThumbnail(context),
                    SizedBox(height: 40.v),
                    _buildSelectDateRangeButton(context),
                    SizedBox(height: 10.v),
                    ValueListenableBuilder<String>(
                      valueListenable: datesNotifier,
                      builder: (context, datesNotifier, child) {
                        return Text(
                          datesNotifier,
                          style: CustomTextStyles.titleSmallDeeppurple500,
                        );
                      },
                    ),
                    SizedBox(height: 40.v),
                    _buildLocation(context),
                    SizedBox(height: 20.v),
                    _buildAddPeople(context, data["people"]),
                    SizedBox(height: 30.v),
                    _buildSelectTags(context, data["tags"]),
                    SizedBox(height: 30.v),
                    _buildPhotos(context),
                    SizedBox(height: 30.v),
                    _buildJournals(context),
                    SizedBox(height: 30.v),
                    _buildRecordings(context),
                    CreateMemoryButton(
                      key: createMemoryButtonKey,
                      title: currentTitle,
                      startDate: startDate,
                      endDate: endDate,
                      // ignore: sdk_version_since
                      thumbnail: thumbnailImage?.path,
                      location: myLocation,
                      people: mySelectedPeople,
                      images: imgList,
                      journalPages: journalList,
                      recordings: recordingPaths,
                      tags: selectedTags.map((tag) => tag.id!).toList(),
                    ),
                  ],
                ),
              ),
            );
          })),
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
            /*PopupMenuItem<String>(
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
            ),*/
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
          onChanged: (text) {
            titleNotifier.value = text;
            createMemoryButtonKey.currentState?.updateParameters(
              title: text,
            );
          },
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

Widget _buildSelectDateRangeButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () => _selectDateRange(context),
      height: 35.v,
      width: null,
      decoration: null,
      text: "Select Dates".tr,
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgCalendar,
          height: 18.adaptSize,
          width: 18.adaptSize,
        ),
      ),
      buttonStyle: CustomButtonStyles.outlineBlackTL17,
      buttonTextStyle: CustomTextStyles.titleSmallDeeppurple500,
    );
  }

void _selectDateRange(BuildContext context) async {
    DateTimeRange? selectedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (selectedRange != null) {
      // Handle the selected range, update your controllers or state accordingly
      startDate = selectedRange.start;
      endDate = selectedRange.end;
      print(startDate);
      print(endDate);
      createMemoryButtonKey.currentState?.updateParameters(
        startDate: startDate,
        endDate: endDate,
      );
      datesNotifier.value =
          "${startDate!.day}/${startDate!.month}/${startDate!.year} - ${endDate!.day}/${endDate!.month}/${endDate!.year}";
    }
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
          LocationInputWidget(
            createMemoryButtonKey: createMemoryButtonKey,
            myLocation: myLocation,
            locationController: locationController,
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
          PeopleList(
            people: people,
            onSelectionChanged: (selectedPeople) {
              mySelectedPeople = selectedPeople;
              print(mySelectedPeople.map((person) => person.name!).toList());
              createMemoryButtonKey.currentState?.updateParameters(
                people: mySelectedPeople,
              );
            },
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSelectTags(BuildContext context, List<LabelItemModel> tags) {
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
    return TagCarousel(
      // Create a list to store the selected tags
      labels: tags,
      selectedLabels: selectedTags, // Pass the selected tags to TagCarousel
      carouselType: CarouselType.TagPicker,
      onLabelTap: (selectedLabel) {
        if (!selectedLabel.isSelected) {
          print('Deselected Tag: ${selectedLabel.label}');
          selectedTags.removeWhere((tag) => tag.label == selectedLabel.label);
        } else {
          print('Selected Tag: ${selectedLabel.label}');
          if (!selectedTags.contains(selectedLabel)) {
            selectedTags.add(selectedLabel);
          }
        }
        print(selectedTags.map((tag) => tag.label!).toList());
        createMemoryButtonKey.currentState?.updateParameters(
          tags: selectedTags.map((tag) => tag.id!).toList(),
        );
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
          final appDir = await pathProvider.getDownloadsDirectory();
          bool appFolderExists =
              await Directory(appDir!.path + '/photos').exists();
          if (!appFolderExists) {
            final created = await Directory(appDir.path + '/photos')
                .create(recursive: true);
            print(created.path);
          }
          final fileName = path.basename(pickedFile.path);
          final savedImage = await File(pickedFile.path)
              .copy('${appDir.path}/photos/$fileName');
          print(savedImage);
          imgList.add(savedImage.path);
          createMemoryButtonKey.currentState?.updateParameters(
            images: imgList,
          );
          imgListNotifier.value = imgList; // Its a file
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
          ValueListenableBuilder<List<String>>(
            valueListenable: imgListNotifier,
            builder: (context, value, child) {
              print("ImageCarousel rebuilt with imgList: $imgList");
              return ImageCarousel(imgList: value);
            },
          ),
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
          ImageCarousel(imgList: journalList)
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
              _buildAddRecording(context),
            ],
          ),
          SizedBox(height: 10.v),
          ValueListenableBuilder<List<String>>(
            valueListenable: recordingsNotifier,
            builder: (context, value, child) {
              return value.isEmpty
                  ? Text("No recordings yet.")
                  : Column(
                      children: value
                          .map((path) => _buildRecordingBox(File(path)))
                          .toList(),
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingBox(File file) {
    return AudioPlayerWidget(
      audioPath: file.path,
      isAsset: false,
    );
  }

  Widget _buildAddRecording(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        _showRecordingDialog(context);
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

  void _showRecordingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<RecordCubit, mem.RecordState>(
          builder: (BuildContext context, mem.RecordState state) {
            if (state is mem.RecordStopped || state is mem.RecordInitial) {
              return AlertDialog(
                title: Text("Recording Options"),
                content: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Spacer(),
                    TextButton(
                        child: Icon(
                          Icons.mic,
                          color: Colors.black,
                          size: 50,
                        ),
                        onPressed: () async {
                          await checkAndRequestPermissions();
                          context.read<RecordCubit>().startRecording();
                        }),
                    Spacer(),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              );
            } else if (state is mem.RecordOn) {
              return SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Spacer(),
                        StreamBuilder<double>(
                          initialData: RecorderConstants.decibleLimit,
                          stream: context.read<RecordCubit>().aplitudeStream(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return AudioVisualizer(amplitude: snapshot.data);
                            }
                            if (snapshot.hasError) {
                              return Text(
                                'Visualizer failed to load',
                                style: TextStyle(color: Colors.black),
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                        Spacer(),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        String? recordingPath =
                            await context.read<RecordCubit>().stopRecording();
                        if (recordingPath != null) {
                          print('Recording saved to: $recordingPath');
                          // Add the path to your list
                          
                            recordingPaths.add(recordingPath);
                          createMemoryButtonKey.currentState?.updateParameters(
                            recordings: recordingPaths,
                          );
                          recordingsNotifier.value = recordingPaths;
                         
                        } else {
                          print('Recording failed');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.stop,
                          color: Colors.black,
                          size: 50,
                        ),
                        height: 100,
                        width: 100,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(
                  'An Error occured',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              );
            }
          },
        );
      },
    );
  }

Widget _buildThumbnail(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle thumbnail image selection
        _showThumbnailOptions(context);
      },
      child: Container(
        width: double.infinity,
        height: 200.0, // You can adjust the size as needed
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ValueListenableBuilder<File?>(
          valueListenable: thumbnailNotifier,
          builder: (context, thumbnailImage, child) {
            return thumbnailImage != null
                ? Stack(
                    children: [
                      Image.file(
                        thumbnailImage,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: GestureDetector(
                          onTap: () {
                            thumbnailNotifier.value = null;
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      "Add Thumbnail",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
          },
        ),
      ),
    );
  }

  void _showThumbnailOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thumbnail Options"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context); // Close the options dialog
                  _takePicture(ImageSource.camera);
                },
                child: Text('Take a Picture'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context); // Close the options dialog
                  _takePicture(ImageSource.gallery);
                },
                child: Text('Pick from Gallery'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _takePicture(ImageSource source) async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await picker.getImage(source: source);

    if (pickedFile != null) {
      final appDir = await pathProvider.getDownloadsDirectory();
      bool appFolderExists = await Directory(appDir!.path + '/photos').exists();
      if (!appFolderExists) {
        final created =
            await Directory(appDir.path + '/photos').create(recursive: true);
        print(created.path);
      }
      final fileName = path.basename(pickedFile.path);
      final savedImage =
          await File(pickedFile.path).copy('${appDir.path}/photos/$fileName');
      print(savedImage);
      thumbnailImage = savedImage;
      createMemoryButtonKey.currentState?.updateParameters(
        thumbnail: thumbnailImage?.path,
      );
      thumbnailNotifier.value = savedImage;
    }
  }
}
abstract class RecorderConstants {
  static const amplitudeCaptureRateInMilliSeconds = 100;

  static const double decibleLimit = -30;

  static const String fileExtention = '.rn';
}

Future<void> checkAndRequestPermissions() async {
  Map<Permission, PermissionStatus> permissions = await [
    Permission.storage,
    Permission.microphone,
  ].request();

  if (permissions[Permission.storage] == PermissionStatus.granted &&
      permissions[Permission.microphone] == PermissionStatus.granted) {
    // Permissions granted, you can now proceed with recording.
  } else {
    print("Permissions not granted before recording.");
  }
}


// ignore: must_be_immutable
class LocationInputWidget extends StatefulWidget {
  LatLng? myLocation;
  final TextEditingController? locationController;
  final GlobalKey<CreateMemoryButtonState> createMemoryButtonKey;

  LocationInputWidget({
    Key? key,
    required this.myLocation,
    required this.locationController,
    required this.createMemoryButtonKey,
  }) : super(key: key);
  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.customBorderTL4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            autofocus: false,
            maxLines: 1,
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            controller: widget.locationController,
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
                    widget.myLocation =
                        LatLng(position.latitude, position.longitude);
                    print(widget.myLocation);
                    widget.createMemoryButtonKey.currentState?.updateParameters(
                      location: widget.myLocation,
                    );
                    setState(() {
                      widget.myLocation = widget.myLocation;
                    });

                    // Update text controller with the current location
                    widget.locationController?.text = locationString;
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
          ),
          SizedBox(height: 4.v),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "msg_search_or_pick_your".tr,
              // style: CustomTextStyles.bodyMedium_1,
            ),
          ),
        ],
      ),
    );
  }
}
