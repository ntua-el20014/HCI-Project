import 'package:anamnesis/core/utils/navigator_service.dart';
import 'package:anamnesis/database/database.dart';
import 'package:anamnesis/presentation/create_memory_screen/models/people_list.dart';
import 'package:anamnesis/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

// I created this button mostly to test the database,
// but it could also be used for the final app.
// It's in a separate file so that it can easily
// be edited or removed.
class CreateMemoryButton extends StatelessWidget {
  final String? title;
  final String? thumbnail;
  final DateTime? startDate;
  final DateTime? endDate;
  final LatLng? location;
  final List<LatLng>? userTrip;
  final bool? trackLocation;
  final List<String>? images;
  final List<String>? journalPages;
  final List<String>? recordings;
  final List<int>? tags;
  final List<PeopleItemModel>? people;

  const CreateMemoryButton({
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: ElevatedButton(
        onPressed: () async {
          print("Inserting memory into database");
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
              people: peopleIds);
          NavigatorService.pushNamed(
            AppRoutes.homeListScreen,
          );
        },
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
}
