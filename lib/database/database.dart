// ignore_for_file: avoid_print

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
    return await openDatabase(path, onCreate: _createTables, version: 1);
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
      FOREIGN KEY(memory_id) REFERENCES memory(id)
    )""");
    await db.execute("""CREATE TABLE memory_journal(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      memory_id INTEGER,
      page_date TEXT,
      page_text TEXT,
      FOREIGN KEY(memory_id) REFERENCES memory(id)
    )""");
    await db.execute("""CREATE TABLE memory_recordings(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      memory_id INTEGER,
      rec_path TEXT,
      UNIQUE(memory_id, rec_path),
      FOREIGN KEY(memory_id) REFERENCES memory(id)
    )""");
    await db.execute("""CREATE TABLE memory_tags(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      memory_id INTEGER,
      tag_id INTEGER,
      UNIQUE(memory_id, tag_id),
      FOREIGN KEY(memory_id) REFERENCES memory(id),
      FOREIGN KEY(tag_id) REFERENCES tag(id)
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
      FOREIGN KEY(memory_id) REFERENCES memory(id),
      FOREIGN KEY(person_id) REFERENCES person(id)
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
      'title': 'Memory 1',
      'thumbnail': 'assets/images/img_thumbnail.png',
      'start_date': DateTime.now().toString(),
      'end_date': DateTime.now().toString(),
      'location': '38.5391242,21.9861981',
      'user_trip':
          '38.5391242,21.9861981;38.7391242,22.1861981;39.1391242,22.2861981',
      'track_location': 0,
    });
    await db.insert('memory', {
      'title': 'Memory 2',
      'thumbnail': 'assets/images/img_thumbnail_56x56.png',
      'start_date': DateTime.now().toString(),
      'end_date': DateTime.now().toString(),
      'location': '35.3775752,24.5683288',
      'user_trip':
          '35.3775752,24.5683288;36.3775752,24.7683288;37.3775752,23.5683288;36.7775752,24.5683288',
      'track_location': 0,
    });

    // Insert into 'memory_images' table
    await db.insert('memory_images', {
      'memory_id': 1,
      'image_path': 'path/to/image1',
    });
    await db.insert('memory_images', {
      'memory_id': 1,
      'image_path': 'path/to/image2',
    });
    await db.insert('memory_images', {
      'memory_id': 2,
      'image_path': 'path/to/image3',
    });

    // Insert into 'memory_journal' table
    await db.insert('memory_journal', {
      'memory_id': 1,
      'page_date': DateTime.now().toString(),
      'page_text': 'Journal entry 1',
    });
    await db.insert('memory_journal', {
      'memory_id': 1,
      'page_date': DateTime.now().toString(),
      'page_text': 'Journal entry 2',
    });

    // Insert into 'memory_recordings' table
    await db.insert('memory_recordings', {
      'memory_id': 1,
      'rec_path': 'path/to/recording1',
    });

    // Insert into 'tag' table
    await db.insert('tag', {
      'label': 'Tag 1',
    });
    await db.insert('tag', {
      'label': 'Tag 2',
    });

    // Insert into 'memory_tags' table
    await db.insert('memory_tags', {
      'memory_id': 1,
      'tag_id': 1,
    });
    await db.insert('memory_tags', {
      'memory_id': 1,
      'tag_id': 2,
    });
    await db.insert('memory_tags', {
      'memory_id': 2,
      'tag_id': 1,
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
      'memory_id': 1,
      'person_id': 3,
    });
    await db.insert('memory_people', {
      'memory_id': 2,
      'person_id': 1,
    });
    await db.insert('memory_people', {
      'memory_id': 2,
      'person_id': 3,
    });
    print("Initial data inserted");
  }

  //Data insertion
  Future<int> insertTag({required label}) async {
    Tag tag = Tag(label: label);
    final db = await this.db;
    return await db.insert('tag', tag.toMap());
  }

  Future<int> insertPerson({required name}) async {
    Person person = Person(name: name);
    final db = await this.db;
    return await db.insert('person', person.toMap());
  }

  Future<int> insertMemory(
      {required title,
      required thumbnail,
      required startDate,
      required endDate,
      required location,
      required userTrip,
      trackLocation = false,
      List<String> images = const [],
      List<String> journalPages = const [],
      List<String> recordings = const [],
      List<int> tags = const [],
      List<int> people = const []}) async {
    final db = await this.db;
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
    return memId;
  }

  //Data retrieval
  Future<List<Map<String, dynamic>>> getTags() async {
    //Now returns every row as a map.
    //Might change this to return a list of Tag objects.
    //Same for getPeople().
    final db = await this.db;
    return await db.query('tag');
  }

  Future<List<Map<String, dynamic>>> getPeople() async {
    final db = await this.db;
    return await db.query('person');
  }

  Future<List<Map<String, dynamic>>> getMemories() async {
    // Returnes all memories and their basic attributes
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query('memory');

    List<Map<String, dynamic>> memories = [];
    for (int i = 0; i < maps.length; i++) {
      Map<String, dynamic> memory = Memory.fromMap(maps[i]).toDatatypeMap();
      memories.add(memory);
    }
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
    // Here I return the page ids.
    // Maybe I'll change this to return maps of text and date.
    final List<Map<String, dynamic>> journalMaps = await db.query(
      'memory_journal',
      where: 'memory_id = ?',
      whereArgs: [id],
    );
    memory['journal_pages'] = journalMaps.map((map) => map["id"]).toList();

    // Get recordings for this memory
    final List<Map<String, dynamic>> recordingMaps = await db.query(
      'memory_recordings',
      columns: ['rec_path'],
      where: 'memory_id = ?',
      whereArgs: [id],
    );
    memory['recordings'] = recordingMaps.map((map) => map['rec_path']).toList();

    // Get tags for this memory
    final List<Map<String, dynamic>> tagMaps = await db.query(
      'memory_tags',
      columns: ['tag_id'],
      where: 'memory_id = ?',
      whereArgs: [id],
    );
    memory['tags'] = tagMaps.map((map) => map['tag_id']).toList();

    // Get people for this memory
    final List<Map<String, dynamic>> personMaps = await db.query(
      'memory_people',
      columns: ['person_id'],
      where: 'memory_id = ?',
      whereArgs: [id],
    );
    memory['people'] = personMaps.map((map) => map['person_id']).toList();

    return memory;
  }

  //Data update

  //Data deletion

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
}
