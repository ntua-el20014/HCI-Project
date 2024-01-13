import 'package:flutter/material.dart';

class MapPin extends StatelessWidget {
  const MapPin({Key? key, int? memId}) : super(key: key);
  // Can get memory id as input.
  // This will be used to get the memory's thumbnail
  // and for the onTap event.

  @override
  Widget build(BuildContext context) {
    // For now this is just a simple icon
    // We plan on making this a custom pin
    // with the memory's thumbnail
    return Icon(
      Icons.location_on,
      size: 30.0,
      color: Colors.red.shade400,
    );
  }
}
