import 'package:anamnesis/database/database.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

// I created this button mostly to test the database,
// but it could also be used for the final app.
// It's in a separate file so that it can easily
// be edited or removed.
class CreateMemoryButton extends StatelessWidget {
  const CreateMemoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: ElevatedButton(
        onPressed: () async {
          print("Inserting memory into database");
          DatabaseHelper dbHelp = DatabaseHelper();
          await dbHelp.insertMemory(
            startDate: DateTime.now(),
            endDate: DateTime.now(),
            location: LatLng(0, 0),
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
