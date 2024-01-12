import 'package:latlong2/latlong.dart';

class Memory {
  int? id;
  String title;
  String thumbnail;
  DateTime startDate;
  DateTime endDate;
  LatLng location;
  List<LatLng> userTrip;
  bool trackLocation;

  Memory(
      {this.id,
      required this.title,
      required this.thumbnail,
      required this.startDate,
      required this.endDate,
      required this.location,
      required this.userTrip,
      required this.trackLocation});

  Map<String, dynamic> toMap() {
    //Returns a map of the memory object with the datatypes understood by the database
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'start_date': startDate.toString(),
      'end_date': endDate.toString(),
      'location': '${location.latitude},${location.longitude}',
      'user_trip': userTrip
          .map((latLng) => '${latLng.latitude},${latLng.longitude}')
          .join(';'),
      'track_location': trackLocation ? 1 : 0,
    };
  }

  factory Memory.fromMap(Map<String, dynamic> map) {
    //Returns a memory object from a map returned by the database
    List<String> locationData = map['location'].split(',');
    List<String> userTripData = map['user_trip'].split(';');

    List<LatLng> userTrip = [];
    for (int i = 0; i < userTripData.length; i++) {
      List<String> tripPoint = userTripData[i].split(',');
      userTrip
          .add(LatLng(double.parse(tripPoint[0]), double.parse(tripPoint[1])));
    }

    return Memory(
      id: map['id'],
      title: map['title'],
      thumbnail: map['thumbnail'],
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']),
      location:
          LatLng(double.parse(locationData[0]), double.parse(locationData[1])),
      userTrip: userTrip,
      trackLocation: map['track_location'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toDatatypeMap() {
    //Returns a map of the memory object with the correct data types
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'start_date': startDate,
      'end_date': endDate,
      'location': location,
      'user_trip': userTrip,
      'track_location': trackLocation,
    };
  }
}

class MemoryImages {
  int? id;
  int memoryId;
  String imagePath;

  MemoryImages({this.id, required this.memoryId, required this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memory_id': memoryId,
      'image': imagePath,
    };
  }

  factory MemoryImages.fromMap(Map<String, dynamic> map) {
    return MemoryImages(
      id: map['id'],
      memoryId: map['memory_id'],
      imagePath: map['image'],
    );
  }
}

class MemoryJournal {
  int? id;
  int memoryId;
  DateTime pageDate;
  String pageText;

  MemoryJournal(
      {this.id,
      required this.memoryId,
      required this.pageDate,
      required this.pageText});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memory_id': memoryId,
      'page_date': pageDate.toString(),
      'page_text': pageText,
    };
  }

  factory MemoryJournal.fromMap(Map<String, dynamic> map) {
    return MemoryJournal(
      id: map['id'],
      memoryId: map['memory_id'],
      pageDate: DateTime.parse(map['page_date']),
      pageText: map['page_text'],
    );
  }

  Map<String, dynamic> toDatatypeMap() {
    return {
      'id': id,
      'memory_id': memoryId,
      'page_date': pageDate,
      'page_text': pageText,
    };
  }
}

class MemoryRecordings {
  int? id;
  int memoryId;
  String recPath;

  MemoryRecordings({this.id, required this.memoryId, required this.recPath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memory_id': memoryId,
      'rec_path': recPath,
    };
  }

  factory MemoryRecordings.fromMap(Map<String, dynamic> map) {
    return MemoryRecordings(
      id: map['id'],
      memoryId: map['memory_id'],
      recPath: map['rec_path'],
    );
  }
}

class MemoryTags {
  int? id;
  int memoryId;
  int tagId;

  MemoryTags({this.id, required this.memoryId, required this.tagId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memory_id': memoryId,
      'tag_id': tagId,
    };
  }

  factory MemoryTags.fromMap(Map<String, dynamic> map) {
    return MemoryTags(
      id: map['id'],
      memoryId: map['memory_id'],
      tagId: map['tag_id'],
    );
  }
}

class Tag {
  int? id;
  String label;

  Tag({this.id, required this.label});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'],
      label: map['label'],
    );
  }
}

class MemoryPeople {
  int? id;
  int memoryId;
  int personId;

  MemoryPeople({this.id, required this.memoryId, required this.personId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memory_id': memoryId,
      'person_id': personId,
    };
  }

  factory MemoryPeople.fromMap(Map<String, dynamic> map) {
    return MemoryPeople(
      id: map['id'],
      memoryId: map['memory_id'],
      personId: map['person_id'],
    );
  }
}

class Person {
  int? id;
  String name;

  Person({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      name: map['name'],
    );
  }
}
