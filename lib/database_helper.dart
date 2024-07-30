import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'family_database.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE family_data(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            relation TEXT,
            head_id TEXT,
            head_name TEXT,
            head_age INTEGER,
            head_occupation TEXT,
            head_gross_monthly_income REAL,
            head_mobile_number TEXT,
            head_gender TEXT,
            head_education_level TEXT,
            head_occupation_type TEXT,
            is_family_head_recieved_aid INTEGER,
            head_recieved_aid_description TEXT,
            member_count INTEGER DEFAULT 0
          )
        ''');

        await db.execute('''
          CREATE TABLE family_members(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            family_id INTEGER,
            idMember TEXT,
            nameMember TEXT,
            genderMember TEXT,
            ageMember INTEGER,
            relationshipMember TEXT,
            educationLevelMember TEXT,
            occupationMember TEXT,
            grossMonthlyIncomeMember REAL,
            mobileNumberMember TEXT,
            isMemberRecievedAid INTEGER,
            recievedAidDescriptionMember TEXT,
            FOREIGN KEY (family_id) REFERENCES family_data(id) ON DELETE CASCADE
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await db.execute(
              'ALTER TABLE family_data ADD COLUMN member_count INTEGER DEFAULT 0');
        }
      },
    );
  }

  Future<int> insertFamily(Map<String, dynamic> family) async {
    final db = await database;

    // Prepare family head data without members
    final familyHeadData = {
      'name': family['name'],
      'relation': family['relation'],
      'head_id': family['head_id'],
      'head_name': family['head_name'],
      'head_age': family['head_age'],
      'head_occupation': family['head_occupation'],
      'head_gross_monthly_income': family['head_gross_monthly_income'],
      'head_mobile_number': family['head_mobile_number'],
      'head_gender': family['head_gender'],
      'head_education_level': family['head_education_level'],
      'head_occupation_type': family['head_occupation_type'],
      'is_family_head_recieved_aid':
          family['is_family_head_recieved_aid'] ? true : false,
      'head_recieved_aid_description': family['head_recieved_aid_description'],
      'member_count': family['member_count'],
    };

    // Insert family head data
    int familyId = await db.insert('family_data', familyHeadData);

    // Insert family member data
    if (family['members'] != null) {
      for (var member in family['members']) {
        member['family_id'] = familyId; // Associate member with family head
        await db.insert('family_members', member);
      }
    }

    return familyId; // Return the family ID
  }

  Future<int> insertFamilyMember(Map<String, dynamic> member) async {
    final db = await database;
    return await db.insert('family_members', member);
  }

  Future<List<Map<String, dynamic>>> getFamiliesWithMembers() async {
    final db = await database;

    // Fetch families from family_data
    final List<Map<String, dynamic>> families =
        await db.query('family_data', orderBy: 'id DESC');

    List<Map<String, dynamic>> familiesWithMembers = [];

    for (var family in families) {
      // Create a new mutable map for each family
      Map<String, dynamic> familyWithMembers = Map.from(family);

      // Fetch members associated with this family
      final List<Map<String, dynamic>> members = await db.query(
        'family_members',
        where: 'family_id = ?',
        whereArgs: [family['id']],
      );

      // Add members to the new family map
      familyWithMembers['members'] = members;

      // Add the family with members to the list
      familiesWithMembers.add(familyWithMembers);
    }

    return familiesWithMembers; // Return the list of families with their members
  }

  Future<List<Map<String, dynamic>>> fetchFamiliesWithMembers() async {
    final databaseHelper = DatabaseHelper();
    return await databaseHelper.getFamiliesWithMembers();
  }

  Future<int> updateFamily(int id, Map<String, dynamic> family) async {
    final db = await database;

    // Update family head data
    await db.update(
        'family_data',
        {
          'name': family['name'],
          'relation': family['relation'],
          'head_id': family['head_id'],
          'head_name': family['head_name'],
          'head_age': family['head_age'],
          'head_occupation': family['head_occupation'],
          'head_gross_monthly_income': family['head_gross_monthly_income'],
          'head_mobile_number': family['head_mobile_number'],
          'head_gender': family['head_gender'],
          'head_education_level': family['head_education_level'],
          'head_occupation_type': family['head_occupation_type'],
          'is_family_head_recieved_aid':
              family['is_family_head_recieved_aid'] ? true : false,
          'head_recieved_aid_description':
              family['head_recieved_aid_description'],
          'member_count': family['member_count'],
        },
        where: 'id = ?',
        whereArgs: [id]);

    // Update family member data
    if (family['members'] != null) {
      // Delete existing members for this family
      await db
          .delete('family_members', where: 'family_id = ?', whereArgs: [id]);

      // Insert updated members
      for (var member in family['members']) {
        member['family_id'] = id; // Associate member with family head
        await db.insert('family_members', member);
      }
    }

    return id; // Return the family ID
  }

  Future<int> deleteFamily(int id) async {
    final db = await database;

    // Delete associated family members
    await db.delete('family_members', where: 'family_id = ?', whereArgs: [id]);

    // Delete family head
    await db.delete('family_data', where: 'id = ?', whereArgs: [id]);

    return id;
  }
}
