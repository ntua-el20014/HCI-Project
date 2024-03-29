import 'package:anamnesis/database/database.dart';
import 'package:anamnesis/presentation/create_memory_screen/models/people_list.dart';
import 'package:anamnesis/presentation/home_list_screen/bloc/home_list_bloc.dart';
import 'bloc/people_picker_bloc.dart';
import 'models/people_picker_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';
class PeoplePickerBottomsheet extends StatefulWidget {
  final void Function(List<PeopleItemModel>)? onPeopleSelected;
  final HomeListBloc homeListBloc;
  const PeoplePickerBottomsheet(
      {required this.homeListBloc, this.onPeopleSelected, Key? key})
      : super(key: key);
  

  Widget builder(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PeoplePickerBloc>(
          create: (context) => PeoplePickerBloc(PeoplePickerState(
            peoplePickerModelObj: PeoplePickerModel(),
          ))
            ..add(PeoplePickerInitialEvent()),
        ),
        BlocProvider.value(value: homeListBloc)
      ],
      child: PeoplePickerBottomsheet(
        homeListBloc: homeListBloc,
        onPeopleSelected: ((List<PeopleItemModel> newSelectedPeople) {}),
      ),
    );
  }

  @override
  _PeoplePickerBottomsheetState createState() =>
      _PeoplePickerBottomsheetState();
}

class _PeoplePickerBottomsheetState extends State<PeoplePickerBottomsheet> {
  List<PeopleItemModel> mySelectedPeople = [];
  late Future<Map<String, dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _getFutureData();
  }

  Future<Map<String, dynamic>> _getFutureData() async {
    print("Getting future data...");
    Map<String, dynamic> futureData = {"people": []};

    DatabaseHelper dbHelper = DatabaseHelper();

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
          Map<String, dynamic> data = snapshot.data ?? {"people": []};
          print("Data: ${data['people']}");
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
                _buildAddPeople(context, data["people"]),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddPeople(
    BuildContext context,
    List<PeopleItemModel> people,
  ) {
    return BlocBuilder<HomeListBloc, HomeListState>(
      builder: (context, homeListState) {
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
                },
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // Access existing filters from HomeListState
                    String existingSearchText =
                        homeListState.existingSearchText ?? '';
                    List<int> existingSelectedTags =
                        homeListState.existingSelectedTags ?? [];
                    List<DateTime> existingDate =
                        homeListState.existingDate ?? [];
                    int? existingDuration = homeListState.existingDuration;

                    // Call the FilterMemoriesEvent with existing filters and selectedPeople
                    context.read<HomeListBloc>().add(
                          FilterMemoriesEvent(
                            searchText: existingSearchText,
                            selectedPeople: mySelectedPeople,
                            selectedTags: existingSelectedTags,
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
