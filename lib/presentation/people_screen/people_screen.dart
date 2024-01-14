import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/database/database.dart';
import 'package:anamnesis/presentation/create_memory_screen/models/people_list.dart';
import 'package:anamnesis/widgets/app_bar/appbar_leading_image.dart';
import 'package:anamnesis/widgets/app_bar/appbar_subtitle.dart';
import 'package:anamnesis/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return PeopleScreen();
  }

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
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
            Map<String, dynamic> data = snapshot.data ?? {"people": []};
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
                    _buildPeopleList(context, data["people"]),
                  ],
                ),
              ),
            );
          })),
    );
  }

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
        text: "My People".tr,
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildPeopleList(BuildContext context, List<PeopleItemModel> people) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.0),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: people.length,
            itemBuilder: (context, index) {
              return _buildPeopleListItem(context, people[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPeopleListItem(BuildContext context, PeopleItemModel person) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          person.name ?? 'Unknown',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'ID: ${person.id ?? 'N/A'}',
          style: TextStyle(fontSize: 14.0),
        ),
        onTap: () {},
      ),
    );
  }
}
