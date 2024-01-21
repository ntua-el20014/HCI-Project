import 'package:anamnesis/database/database.dart';
import 'package:anamnesis/presentation/create_memory_screen/models/people_list.dart';
import 'package:anamnesis/presentation/home_list_screen/bloc/home_list_bloc.dart';
import 'package:anamnesis/presentation/home_list_screen/models/label_item_model.dart';
import 'bloc/tag_picker_bloc.dart';
import 'models/tag_picker_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';

class TagPickerBottomsheet extends StatefulWidget {
  final void Function(List<PeopleItemModel>)? onTagSelected;
  final HomeListBloc homeListBloc;
  const TagPickerBottomsheet(
      {required this.homeListBloc, this.onTagSelected, Key? key})
      : super(key: key);

  Widget builder(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TagPickerBloc>(
          create: (context) => TagPickerBloc(TagPickerState(
            tagPickerModelObj: TagPickerModel(),
          ))
            ..add(TagPickerInitialEvent()),
        ),
        BlocProvider.value(value: homeListBloc)
      ],
      child: TagPickerBottomsheet(
        homeListBloc: homeListBloc,
      ),
    );
  }

  @override
  _TagPickerBottomsheetState createState() => _TagPickerBottomsheetState();
}

class _TagPickerBottomsheetState extends State<TagPickerBottomsheet> {
  List<LabelItemModel> mySelectedTags = [];
  late Future<Map<String, dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _getFutureData();
  }

  Future<Map<String, dynamic>> _getFutureData() async {
    // print("Getting future data...");
    Map<String, dynamic> futureData = {"tags": []};

    DatabaseHelper dbHelper = DatabaseHelper();

    // Create tags list
    List<Map<String, dynamic>> tags = await dbHelper.getTags();

    List<LabelItemModel> tagsList = [];
    for (Map<String, dynamic> tag in tags) {
      tagsList.add(LabelItemModel(
        label: tag["label"],
        id: tag["id"],
        memoryCount: tag["memory_count"] ?? 0,
      ));
    }
    futureData["tags"] = tagsList;

    return futureData;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<Map<String, dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show loading spinner while waiting for location
          } else if (snapshot.hasError) {
            return Text(
                'Error: ${snapshot.error}'); // Show error message if an error occurred
          }
          Map<String, dynamic> data = snapshot.data ?? {"tags": []};
          print("Data: ${data['tags']}");
          return Container(
            width: 363.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.customBorderTL28,
            ),
            child: SingleChildScrollView(
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
                  _buildTagsList(context, data["tags"]),
                  SizedBox(height: 6.v),
                  _buildAddTag(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTagsList(BuildContext context, List<LabelItemModel> tags) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tags",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: tags.length,
            itemBuilder: (context, index) {
              return _buildTagsListItem(context, tags[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTagsListItem(BuildContext context, LabelItemModel tag) {
    bool isSelected = mySelectedTags.contains(tag);
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                tag.label ?? 'Unknown',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                size: 20,
                color: isSelected ? Colors.blue : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  if (isSelected) {
                    mySelectedTags.remove(tag);
                  } else {
                    mySelectedTags.add(tag);
                  }
                });
              },
            )
          ],
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildAddTag(
    BuildContext context,
  ) {
    return BlocBuilder<HomeListBloc, HomeListState>(
      builder: (context, homeListState) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 13.v),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // Access existing filters from HomeListState
                    String existingSearchText =
                        homeListState.existingSearchText ?? '';
                    List<DateTime> existingDate =
                        homeListState.existingDate ?? [];
                    int? existingDuration = homeListState.existingDuration;
                    List<PeopleItemModel> existingSelectedPeople =
                        homeListState.existingSelectedPeople ?? [];

                    // Call the FilterMemoriesEvent with existing filters and selectedTag
                    context.read<HomeListBloc>().add(
                          FilterMemoriesEvent(
                            selectedPeople: existingSelectedPeople,
                            searchText: existingSearchText,
                            selectedTags:
                                mySelectedTags.map((e) => e.id!).toList(),
                            date: existingDate,
                            duration: existingDuration,
                          ),
                        );
                    Navigator.of(context).pop();
                  },
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
