import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/database/database.dart';
import 'package:anamnesis/presentation/create_memory_screen/models/people_list.dart';
import 'package:anamnesis/presentation/home_list_screen/models/label_item_model.dart';
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
    // print("Getting future data...");
    Map<String, dynamic> futureData = {"people": [], "tags": []};

    DatabaseHelper dbHelper = DatabaseHelper();

    // Create people list
    List<Map<String, dynamic>> people = await dbHelper.getPeople();

    List<PeopleItemModel> peopleList = [];
    for (Map<String, dynamic> person in people) {
      peopleList.add(PeopleItemModel(
        name: person["name"],
        id: person["id"],
        memoryCount: person["memory_count"] ?? 0,
      ));
    }
    futureData["people"] = peopleList;

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
                snapshot.data ?? {"people": [], "tags": []};

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
                    SizedBox(height: 20.v),
                    _buildTagsList(context, data["tags"]),
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
        text: "People & Tags",
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
          Text(
            "People",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
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
        title: Row(
          children: [
            Expanded(
              child: Text(
                person.name ?? 'Unknown',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                size: 20,
                color: Colors.black,
              ),
              onPressed: () {
                _handleDeletePerson(person);
              },
            )
          ],
        ),
        subtitle: Text(
          'Appears in ${person.memoryCount} ${person.memoryCount == 1 ? 'memory' : 'memories'}',
          style: TextStyle(fontSize: 14.0),
        ),
        onTap: () {},
      ),
    );
  }

  void _handleDeletePerson(PeopleItemModel person) {
    if (person.memoryCount == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete Person"),
            content: Text(
                'This person has no memories associated with them. Do you wish to delete them?'),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: () async {
                  DatabaseHelper dbHelper = DatabaseHelper();
                  await dbHelper.deletePerson(person.id!);
                  Navigator.of(context).pop();
                  setState(() {});
                },
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("You cannot delete a person associated with memories."),
      ));
    }
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
                Icons.close,
                size: 20,
                color: Colors.black,
              ),
              onPressed: () {
                _handleDeleteTag(tag);
              },
            )
          ],
        ),
        subtitle: Text(
          'Appears in ${tag.memoryCount} ${tag.memoryCount == 1 ? 'memory' : 'memories'}',
          style: TextStyle(fontSize: 14.0),
        ),
        onTap: () {},
      ),
    );
  }

  void _handleDeleteTag(LabelItemModel tag) {
    if (tag.memoryCount == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete Tag"),
            content: Text(
                'This tag has no memories associated with it. Do you wish to delete it?'),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: () async {
                  DatabaseHelper dbHelper = DatabaseHelper();
                  await dbHelper.deleteTag(tag.id!);
                  Navigator.of(context).pop();
                  setState(() {});
                },
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("You cannot delete a tag associated with memories."),
      ));
    }
  }
}
