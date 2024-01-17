import 'package:anamnesis/core/utils/navigator_service.dart';
import 'package:anamnesis/database/database.dart';
import 'package:anamnesis/presentation/create_memory_screen/models/people_list.dart';
import 'package:anamnesis/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

// ignore: must_be_immutable
class CreateMemoryButton extends StatefulWidget {
  String? title;
  String? thumbnail;
  DateTime? startDate;
  DateTime? endDate;
  LatLng? location;
  List<LatLng>? userTrip;
  bool? trackLocation;
  List<String>? images;
  List<String>? journalPages;
  List<String>? recordings;
  List<int>? tags;
  List<PeopleItemModel>? people;

  CreateMemoryButton({
    Key? key,
    this.title,
    this.thumbnail,
    this.startDate,
    this.endDate,
    this.location,
    this.userTrip,
    this.trackLocation,
    this.images,
    this.journalPages,
    this.recordings,
    this.tags,
    this.people,
  }) : super(key: key);

  @override
  CreateMemoryButtonState createState() => CreateMemoryButtonState();
}

class CreateMemoryButtonState extends State<CreateMemoryButton> {
  String? title;
  String? thumbnail;
  DateTime? startDate;
  DateTime? endDate;
  LatLng? location;
  List<LatLng>? userTrip;
  bool? trackLocation;
  List<String>? images;
  List<String>? journalPages;
  List<String>? recordings;
  List<int>? tags;
  List<PeopleItemModel>? people;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    thumbnail = widget.thumbnail;
    startDate = widget.startDate;
    endDate = widget.endDate;
    location = widget.location;
    userTrip = widget.userTrip;
    trackLocation = widget.trackLocation;
    images = widget.images;
    journalPages = widget.journalPages;
    recordings = widget.recordings;
    tags = widget.tags;
    people = widget.people;
  }

  void updateParameters({
    String? title,
    String? thumbnail,
    DateTime? startDate,
    DateTime? endDate,
    LatLng? location,
    List<LatLng>? userTrip,
    bool? trackLocation,
    List<String>? images,
    List<String>? journalPages,
    List<String>? recordings,
    List<int>? tags,
    List<PeopleItemModel>? people,
  }) {
    setState(() {
      this.title = title ?? this.title;
      this.thumbnail = thumbnail ?? this.thumbnail;
      this.startDate = startDate ?? this.startDate;
      this.endDate = endDate ?? this.endDate;
      this.location = location ?? this.location;
      this.userTrip = userTrip ?? this.userTrip;
      this.trackLocation = trackLocation ?? this.trackLocation;
      this.images = images ?? this.images;
      this.journalPages = journalPages ?? this.journalPages;
      this.recordings = recordings ?? this.recordings;
      this.tags = tags ?? this.tags;
      this.people = people ?? this.people;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: ElevatedButton(
        onPressed: () async => _onCreateMemoryButtonPressed(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Text(
            "Create Memory",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onCreateMemoryButtonPressed(BuildContext context) async {
    print(title);
    print(thumbnail);
    print(startDate);
    print(endDate);
    print(location);
    print(userTrip);
    print(trackLocation);
    print(images);
    print(journalPages);
    print(recordings);
    print(tags);
    print(people!.map((person) => person.name!).toList());

    if (_checkIfMemoryIsValid()) {
      print("Check passed. Creating memory...");
      DatabaseHelper dbHelp = DatabaseHelper();

      List<int> peopleIds = [];
      if (people != null) {
        for (int i = 0; i < people!.length; i++) {
          if (people![i].id != null) peopleIds.add(people![i].id!);
        }
      }

      await dbHelp.insertMemory(
        title: title,
        thumbnail: thumbnail,
        startDate: startDate,
        endDate: endDate,
        location: location,
        userTrip: userTrip,
        trackLocation: trackLocation,
        images: images,
        journalPages: journalPages,
        recordings: recordings,
        tags: tags,
        people: peopleIds,
      );
      NavigatorService.pushNamed(AppRoutes.homeListScreen);
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill in Title and Location.'),
      ));
      setState(() {});
    }
  }

  bool _checkIfMemoryIsValid() {
    return title != null && location != null;
  }
}
