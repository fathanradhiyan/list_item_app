part of 'databases.dart';

class ItemDatabase {
  static final ItemDatabase instance = ItemDatabase._init();

  static Database? _database;

  ItemDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('fathan_test.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final itemIdType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final itemNameType = 'TEXT NOT NULL';
    final barcodeType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableItems (
    ${ItemFields.itemId} $itemIdType,
    ${ItemFields.itemName} $itemNameType, 
    ${ItemFields.barcode} $barcodeType
    )
    ''');
  }

  Future<Item> create(Item item) async {
    final db = await instance.database;
    final id = await db.insert(tableItems, item.toJson());
    return item.copy(itemId: id);
  }

  Future<Item> readItem(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableItems,
      columns: ItemFields.values,
      where: '${ItemFields.itemId} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Item.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Item>> readAllItems({String? search}) async {
    final db = await instance.database;

    final result = await db.query(tableItems,
      where: search != null? '${ItemFields.itemId} like ? or ${ItemFields.itemName} like ? or ${ItemFields.barcode} like ?' : null,
      whereArgs: search != null? ['%$search%', '%$search%', '%$search%'] : null
    );

    return result.map((json) => Item.fromJson(json)).toList();

  }

  Future<void> update(Item item) async {
    final db = await instance.database;

    await db.update(
      tableItems,
      item.toJson(),
      where: '${ItemFields.itemId} = ?',
      whereArgs: [item.itemId]
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableItems,
      where: '${ItemFields.itemId} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
