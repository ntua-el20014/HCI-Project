// ignore_for_file: avoid_print

import 'package:latlong2/latlong.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'database_tables.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    print("Initializing database");
    _db = await initDb();
    await insertInitialData();
    return _db!;
  }

  //Database initialization
  initDb() async {
    String path = join(await getDatabasesPath(), 'anamnesis.db');
    print("Opening database in $path");
    return await openDatabase(
      path,
      onCreate: _createTables,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  //Data insertion
  Future<int> insertTag({required String label}) async {
    Tag tag = Tag(label: label);
    final db = await this.db;
    return await db.insert('tag', tag.toMap());
  }

  Future<int> insertPerson({required String name}) async {
    Person person = Person(name: name);
    final db = await this.db;
    return await db.insert('person', person.toMap());
  }

  Future<int> insertMemory(
      {String? title,
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
      List<int>? people}) async {
    print("Inserting memory into database");
    final db = await this.db;
    title ??= "Untitled Memory";
    thumbnail ??= "assets/images/image_not_found.png";
    startDate ??= DateTime.now();
    endDate ??= startDate;
    location ??= const LatLng(0, 0);
    userTrip ??= [location];
    trackLocation ??= false;
    images ??= [];
    journalPages ??= [];
    recordings ??= [];
    tags ??= [];
    people ??= [];

    //Create memory table entry
    Memory memory = Memory(
        title: title,
        thumbnail: thumbnail,
        startDate: startDate,
        endDate: endDate,
        location: location,
        userTrip: userTrip,
        trackLocation: trackLocation);
    int memId = await db.insert('memory', memory.toMap());

    //Add memory images
    for (String image in images) {
      MemoryImages memImg = MemoryImages(memoryId: memId, imagePath: image);
      await db.insert('memory_images', memImg.toMap());
    }

    //Add memory journal pages
    for (String page in journalPages) {
      MemoryJournal memJournal = MemoryJournal(
          memoryId: memId, pageText: page, pageDate: DateTime.now());
      await db.insert('memory_journal', memJournal.toMap());
    }

    //Add memory recordings
    for (String recording in recordings) {
      MemoryRecordings memRec =
          MemoryRecordings(memoryId: memId, recPath: recording);
      await db.insert('memory_recordings', memRec.toMap());
    }

    //Add memory tags
    for (int tag in tags) {
      MemoryTags memTag = MemoryTags(memoryId: memId, tagId: tag);
      await db.insert('memory_tags', memTag.toMap());
    }

    //Add memory people
    for (int person in people) {
      MemoryPeople memPerson = MemoryPeople(memoryId: memId, personId: person);
      await db.insert('memory_people', memPerson.toMap());
    }
    print("Memory inserted");
    return memId;
  }

  //Data retrieval
  Future<List<Map<String, dynamic>>> getTags() async {
    final db = await this.db;
    return await db.rawQuery('''
      SELECT tag.id, tag.label, COUNT(memory_tags.memory_id) AS memory_count
      FROM tag LEFT JOIN memory_tags ON tag.id = memory_tags.tag_id
      GROUP BY tag.id
    ''');
  }

  Future<List<Map<String, dynamic>>> getPeople() async {
    final db = await this.db;

    return await db.rawQuery('''
      SELECT person.id, person.name, COUNT(memory_people.memory_id) AS memory_count
      FROM person LEFT JOIN memory_people ON person.id = memory_people.person_id
      GROUP BY person.id
    ''');
  }

  Future<List<Map<String, dynamic>>> getMemories({
    String? title,
    List<int>? tags,
    List<DateTime>? date, //[lowerEnd, upperEnd], lowerEnd<=startDate<=upperEnd
    int? duration, // in days
    List<int>? people,
  }) async {
    // Returnes all memories and their basic attributes
    // after aplying any given filters
    title ??= "";
    tags ??= [];
    date ??= [];
    duration ??= null;
    people ??= [];

    final db = await this.db;

    // tags filter
    String tagsJoin = (tags.length == 0)
        ? ""
        : "LEFT JOIN memory_tags ON memory.id = memory_tags.memory_id";
    String tagsWhere = (tags.length == 0)
        ? ""
        : "AND memory_tags.tag_id IN (${tags.join(",")})";

    // people filter
    String peopleJoin = (people.length == 0)
        ? ""
        : "LEFT JOIN memory_people ON memory.id = memory_people.memory_id";
    String peopleWhere = (people.length == 0)
        ? ""
        : "AND memory_people.person_id IN (${people.join(",")})";

    // date filter
    String dateWhere = (date.length != 2)
        ? ""
        : "AND memory.start_date BETWEEN '${date[0].toString()}' AND '${date[1].toString()}'";

    // duration filter
    String durationWhere = (duration == null)
        ? ""
        : "AND memory.end_date BETWEEN memory.start_date AND date(memory.start_date, '+${duration} day')";

    String query = '''
      SELECT memory.*
      FROM memory
      ${tagsJoin}
      ${peopleJoin}
      WHERE memory.title LIKE '%${title}%'
      ${tagsWhere}
      ${peopleWhere}
      ${dateWhere}
      ${durationWhere}
      GROUP BY memory.id
      ''';

    final List<Map<String, dynamic>> maps = await db.rawQuery(query);

    // final List<Map<String, dynamic>> maps = await db.query("memory");

    List<Map<String, dynamic>> memories = [];
    for (int i = 0; i < maps.length; i++) {
      Map<String, dynamic> memory = Memory.fromMap(maps[i]).toDatatypeMap();
      memories.add(memory);
    }

    // print("getMemories() ended successfuly, with the query:\n$query");
    return memories;
  }

  Future<Map<String, dynamic>> getMemoryInfo(int id) async {
    final db = await this.db;
    //Get basic memory info
    final List<Map<String, dynamic>> maps = await db.query(
      'memory',
      where: 'id = ?',
      whereArgs: [id],
    );

    //Handle Errors
    if (maps.isEmpty) {
      return {};
    } else if (maps.length > 1) {
      throw Exception("Multiple entries with same id");
    }

    //If everything is ok:
    Map<String, dynamic> memory = Memory.fromMap(maps.first).toDatatypeMap();

    // Get images for this memory
    final List<Map<String, dynamic>> imageMaps = await db.query(
      'memory_images',
      columns: ['image_path'],
      where: 'memory_id = ?',
      whereArgs: [id],
    );
    memory['images'] = imageMaps.map((map) => map['image_path']).toList();

    // Get journal pages for this memory
    final List<Map<String, dynamic>> journalMaps = await db.query(
      'memory_journal',
      where: 'memory_id = ?',
      whereArgs: [id],
    );
    memory['journal_pages'] = journalMaps;

    // Get recordings for this memory
    final List<Map<String, dynamic>> recordingMaps = await db.query(
      'memory_recordings',
      columns: ['rec_path'],
      where: 'memory_id = ?',
      whereArgs: [id],
    );
    memory['recordings'] = recordingMaps.map((map) => map['rec_path']).toList();

    // Get tags for this memory
    final List<Map<String, dynamic>> tagMaps = await db.rawQuery('''
      SELECT tag.id, tag.label
      FROM tag JOIN memory_tags ON tag.id = memory_tags.tag_id
      WHERE memory_tags.memory_id = ${id}
    ''');
    memory['tags'] = tagMaps;

    // Get people for this memory
    final List<Map<String, dynamic>> personMaps = await db.rawQuery('''
      SELECT person.id, person.name
      FROM person JOIN memory_people ON person.id = memory_people.person_id
      WHERE memory_people.memory_id = ${id}
    ''');
    memory['people'] = personMaps;

    return memory;
  }

  Future<int> personMemoryCount() async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT person.id, person.name, COUNT(memory_people.memory_id) AS memory_count
      FROM person
      LEFT JOIN memory_people ON person.id = memory_people.person_id
      GROUP BY person.id
    ''');
    return maps.length;
  }

  //Data update

  //Data deletion
  Future<void> deleteMemory(int id) async {
    //Handles deletion of a memory from the database
    //but also the deletion of associated files

    final db = await this.db;

    // Delete associated image files
    // final List<Map<String, dynamic>> imageMaps = await db.query(
    //   'memory_images',
    //   columns: ['image_path'],
    //   where: 'memory_id = ?',
    //   whereArgs: [id],
    // );
    // for (Map<String, dynamic> imageMap in imageMaps) {
    //   // need to know where files are stored first
    //   // await deleteFile(imageMap['image_path']);
    // }

    // Delete associated recording files
    // final List<Map<String, dynamic>> recordingMaps = await db.query(
    //   'memory_recordings',
    //   columns: ['rec_path'],
    //   where: 'memory_id = ?',
    //   whereArgs: [id],
    // );
    // for (Map<String, dynamic> recordingMap in recordingMaps) {
    //   File recFile = File(recordingMap['rec_path']);
    //   if (await recFile.exists()) {
    //     await recFile.delete();
    //   }
    // }

    await db.delete('memory', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteTag(int id) async {
    final db = await this.db;
    await db.delete('tag', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deletePerson(int id) async {
    final db = await this.db;
    await db.delete('person', where: 'id = ?', whereArgs: [id]);
  }

  //Helper functions
  Future<bool> _isDatabaseEmpty() async {
    print("Checking if database is empty");
    final db = await this.db;

    // List of all tables in the database
    List<String> tables = [
      'memory',
      'memory_images',
      'memory_journal',
      'memory_recordings',
      'memory_tags',
      'tag',
      'memory_people',
      'person',
    ];

    for (String table in tables) {
      final count = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM $table'));
      if (count != null && count > 0) {
        return false;
      }
    }

    return true;
  }

  void _createTables(Database db, int version) async {
    print("Creating tables");
    await db.execute("""CREATE TABLE memory(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      thumbnail TEXT,
      start_date TEXT,
      end_date TEXT,
      location TEXT,
      user_trip TEXT,
      track_location INTEGER
    )""");
    await db.execute("""CREATE TABLE memory_images(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      memory_id INTEGER,
      image_path TEXT,
      UNIQUE(memory_id, image_path),
      FOREIGN KEY(memory_id) REFERENCES memory(id) ON DELETE CASCADE
    )""");
    await db.execute("""CREATE TABLE memory_journal(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      memory_id INTEGER,
      page_date TEXT,
      page_text TEXT,
      FOREIGN KEY(memory_id) REFERENCES memory(id) ON DELETE CASCADE
    )""");
    await db.execute("""CREATE TABLE memory_recordings(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      memory_id INTEGER,
      rec_path TEXT,
      UNIQUE(memory_id, rec_path),
      FOREIGN KEY(memory_id) REFERENCES memory(id) ON DELETE CASCADE
    )""");
    await db.execute("""CREATE TABLE memory_tags(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      memory_id INTEGER,
      tag_id INTEGER,
      UNIQUE(memory_id, tag_id),
      FOREIGN KEY(memory_id) REFERENCES memory(id) ON DELETE CASCADE,
      FOREIGN KEY(tag_id) REFERENCES tag(id) ON DELETE RESTRICT
    )""");
    await db.execute("""CREATE TABLE tag(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      label TEXT
    )""");
    await db.execute("""CREATE TABLE memory_people(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      memory_id INTEGER,
      person_id INTEGER,
      UNIQUE(memory_id, person_id),
      FOREIGN KEY(memory_id) REFERENCES memory(id) ON DELETE CASCADE,
      FOREIGN KEY(person_id) REFERENCES person(id) ON DELETE RESTRICT 
    )""");
    await db.execute("""CREATE TABLE person(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT
    )""");
    print("Tables created");
  }

  Future<void> insertInitialData() async {
    if (!await _isDatabaseEmpty()) {
      print("No need to insert initial data");
      return;
    }
    print("Inserting initial data");
    final db = await this.db;

    // Insert into 'memory' table
    await db.insert('memory', {
      'title': 'Chilling at NTUA',
      'thumbnail': 'assets/images/img_thumbnail.png',
      'start_date': DateTime.now().toString(),
      'end_date': DateTime.now().toString(),
      'location': ' 37.9776001,23.7832768',
      'user_trip': ' 37.9776001, 23.7832768; 37.8676001, 23.7732768',
      'track_location': 0,
    });
    await db.insert('memory', {
      'title': 'Crete road trip',
      'thumbnail': 'assets/images/img_thumbnail_56x56.png',
      'start_date': DateTime.now().subtract(Duration(days: 30)).toString(),
      'end_date': DateTime.now().subtract(Duration(days: 22)).toString(),
      'location': '35.3775752,24.5683288',
      'user_trip':
          '35.3775752,24.5683288;36.3775752,24.7683288;37.3775752,23.5683288;36.7775752,24.5683288',
      'track_location': 0,
    });
    await db.insert('memory', {
      'title': 'Trekking in Oiti',
      'thumbnail': 'assets/images/img_img_20231007_141500_230x360.png',
      'start_date': DateTime.now().subtract(Duration(days: 4)).toString(),
      'end_date': DateTime.now().subtract(Duration(days: 2)).toString(),
      'location': '38.5391242,21.9861981',
      'user_trip':
          '38.5391242,21.9861981;38.7391242,22.1861981;39.1391242,22.2861981',
      'track_location': 0,
    });
    await db.insert('memory', {
      'title': 'These memories',
      'thumbnail': 'assets/images/img_periodikos_pinakas_134x121.png',
      'start_date': DateTime.now().toString(),
      'end_date': DateTime.now().toString(),
      'location': '40.6583261, 22.9413016',
      'user_trip': '40.6583261, 22.9413016',
      'track_location': 0,
    });
    await db.insert('memory', {
      'title': 'Are here',
      'thumbnail': 'assets/images/img_periodikos_pinakas_134x121.png',
      'start_date': DateTime.now().toString(),
      'end_date': DateTime.now().toString(),
      'location': '0.0,0.0',
      'user_trip': '0.0,0.0',
      'track_location': 0,
    });
    await db.insert('memory', {
      'title': 'To demonstrate',
      'thumbnail': 'assets/images/img_periodikos_pinakas_134x121.png',
      'start_date': DateTime.now().toString(),
      'end_date': DateTime.now().toString(),
      'location': '41.8603732, 12.5000386',
      'user_trip': '41.8603732, 12.5000386',
      'track_location': 0,
    });
    await db.insert('memory', {
      'title': 'The list view',
      'thumbnail': 'assets/images/img_periodikos_pinakas_134x121.png',
      'start_date': DateTime.now().toString(),
      'end_date': DateTime.now().toString(),
      'location': '38.1728,23.7572',
      'user_trip': '38.1728,23.7572',
      'track_location': 0,
    });

    // Insert into 'memory_images' table
    await db.insert('memory_images', {
      'memory_id': 1,
      'image_path': 'assets/images/dummy1.jpg',
    });
    await db.insert('memory_images', {
      'memory_id': 2,
      'image_path': 'assets/images/dummy2.jpg',
    });
    await db.insert('memory_images', {
      'memory_id': 3,
      'image_path': 'assets/images/dummy3.jpg',
    });
    await db.insert('memory_images', {
      'memory_id': 2,
      'image_path': 'assets/images/dummy4.jpg',
    });
    await db.insert('memory_images', {
      'memory_id': 2,
      'image_path': 'assets/images/dummy5.jpg',
    });
    await db.insert('memory_images', {
      'memory_id': 1,
      'image_path': 'assets/images/dummy6.jpg',
    });
    await db.insert('memory_images', {
      'memory_id': 3,
      'image_path': 'assets/images/dummy7.jpg',
    });
    await db.insert('memory_images', {
      'memory_id': 3,
      'image_path': 'assets/images/dummy8.jpg',
    });
    await db.insert('memory_images', {
      'memory_id': 3,
      'image_path': 'assets/images/dummy9.jpg',
    });
    await db.insert('memory_images', {
      'memory_id': 2,
      'image_path': 'assets/images/dummy10.jpg',
    });
    await db.insert('memory_images', {
      'memory_id': 1,
      'image_path': 'assets/images/img_thumbnail_1.png',
    });
    await db.insert('memory_images', {
      'memory_id': 3,
      'image_path':
          'assets/images/img_mikrh_mprostinh_stampa_omada_134x119.png',
    });

    // Insert into 'memory_journal' table
    await db.insert('memory_journal', {
      'memory_id': 1,
      'page_date': DateTime.now().toString(),
      'page_text':
          'We had quite the time at NTUA. We set up our hammocks and... started studyng!',
    });
    await db.insert('memory_journal', {
      'memory_id': 1,
      'page_date': DateTime.now().toString(),
      'page_text':
          'Honestly, I don\'t know if the Journal is worth the implementation effort.',
    });

    // Insert into 'memory_recordings' table
    await db.insert('memory_recordings', {
      'memory_id': 1,
      'rec_path': 'recordings/ring.mp3',
    });
    await db.insert('memory_recordings', {
      'memory_id': 1,
      'rec_path': 'recordings/dragon.mp3',
    });
    await db.insert('memory_recordings', {
      'memory_id': 1,
      'rec_path': 'recordings/work.mp3',
    });
    await db.insert('memory_recordings', {
      'memory_id': 1,
      'rec_path': 'recordings/shallnotpass.mp3',
    });
    await db.insert('memory_recordings', {
      'memory_id': 2,
      'rec_path': 'recordings/myprecious.mp3',
    });
    await db.insert('memory_recordings', {
      'memory_id': 2,
      'rec_path': 'recordings/end.mp3',
    });

    // Insert into 'tag' table
    await db.insert('tag', {
      'label': 'Summer',
    });
    await db.insert('tag', {
      'label': 'NTUA',
    });
    await db.insert('tag', {
      'label': 'Beers with the boys',
    });
    await db.insert('tag', {
      'label': 'Road trip',
    });
    await db.insert('tag', {
      'label': 'Outdoors',
    });

    // Insert into 'memory_tags' table
    await db.insert('memory_tags', {
      'memory_id': 1,
      'tag_id': 2,
    });
    await db.insert('memory_tags', {
      'memory_id': 2,
      'tag_id': 1,
    });
    await db.insert('memory_tags', {
      'memory_id': 2,
      'tag_id': 3,
    });
    await db.insert('memory_tags', {
      'memory_id': 2,
      'tag_id': 4,
    });
    await db.insert('memory_tags', {
      'memory_id': 3,
      'tag_id': 3,
    });
    await db.insert('memory_tags', {
      'memory_id': 3,
      'tag_id': 5,
    });

    // Insert into 'person' table
    await db.insert('person', {
      'name': 'Nick',
    });
    await db.insert('person', {
      'name': 'Mike',
    });
    await db.insert('person', {
      'name': 'Bill',
    });
    await db.insert('person', {
      'name': 'Philip',
    });

    // Insert into 'memory_people' table
    await db.insert('memory_people', {
      'memory_id': 1,
      'person_id': 1,
    });
    await db.insert('memory_people', {
      'memory_id': 1,
      'person_id': 2,
    });
    await db.insert('memory_people', {
      'memory_id': 2,
      'person_id': 2,
    });
    await db.insert('memory_people', {
      'memory_id': 2,
      'person_id': 4,
    });
    await db.insert('memory_people', {
      'memory_id': 3,
      'person_id': 1,
    });
    await db.insert('memory_people', {
      'memory_id': 3,
      'person_id': 2,
    });
    await db.insert('memory_people', {
      'memory_id': 3,
      'person_id': 3,
    });
    await db.insert('memory_people', {
      'memory_id': 3,
      'person_id': 4,
    });
    print("Initial data inserted");
  }
}
