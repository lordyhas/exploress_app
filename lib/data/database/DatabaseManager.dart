
import 'dart:io';

import 'package:exploress/data/values.dart';
import 'package:exploress_repository/exploress_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../objectbox.g.dart';
import 'model/AppSettingModel.dart';
import 'model/SettingData.dart';



enum Docs {settings, phone, messages,}

abstract class XDatabaseManager {
  void onInit<E extends HiveObject>(TypeAdapter<E> typeAdapter);
  void onUpdate();
  //Future<bool> addObject<T extends HiveObject >(T hiveObject,  [String? key]);
  //Future<bool> addField(Object object);
  //Future<bool> deleteField(Object object);
  //Future<bool> updateField(Object object);
  //Future<Object> getField(Object object);
  //Future<List<Object>>  getAllData(Object object);

}

class HiveBoxManager extends XDatabaseManager {
  HiveBoxManager();

  factory HiveBoxManager.init() {

    return HiveBoxManager();
  }
  static const settingBoxName = "settingBoxTest";
  static const messageBoxName = "messageBox";
  @override
  void onInit<E extends HiveObject>(TypeAdapter<E> typeAdapter) async {
    Log.out("HiveBox"," HiveBoxManager.onInit() ===  ===");
    Directory appDocDirectory = await getApplicationDocumentsDirectory();


    /*new Directory(appDocDirectory.path+'/'+'dir').create(recursive: true)
      // The created directory is returned as a Future.
        .then((Directory directory) {
      print('Path of New Dir: '+directory.path);
    });*/
    //var path = Directory.current.path;
    var path = appDocDirectory.path; //Directory.current.path;
    Log.out("HiveBox","HiveBoxManager.onInit(Path: $path ) ===  ===");
    //await Hive.initFlutter();
    //Hive..init(path)..registerAdapter(typeAdapter);

    //await Hive.initFlutter();
    //Hive.init(path);
    //Hive..init(path)..registerAdapter<E>(typeAdapter);
    Hive..init(path)..registerAdapter<AppSetting>(AppSettingAdapter());

    //var box = await Hive.openBox('testBox');

    /*await Future.wait([
      Hive.openBox<AppSetting>(HiveBoxManager.settingBoxName),
      //Hive.openBox('stories'),
    ]);*/
    Hive.openBox<AppSetting>(HiveBoxManager.settingBoxName);



  }

  Future<AppSetting?> get getSetting async {
    var box = Hive.box<AppSetting>(HiveBoxManager.settingBoxName);

    //AppSetting appSetting = new AppSetting()..language = 0 ..language = 0;
    //box.put(AppSetting.keyName, appSetting);
    if(box.isEmpty){
      AppSetting appSetting = new AppSetting()..language = 0 ..language = 0;
      box.put(AppSetting.keyName, appSetting);
    }

    AppSetting? setting = box.get(AppSetting.keyName)!;

    Log.out("HiveBox"," HiveBoxManager.openedSettingBox("
        "\ntheme: ${setting.theme} "
        "\nlanguage: ${setting.language}) ===  ===");


    //box.close();
    return setting;
  }

  void updateTheme(StylesThemeState state) async {
    var box = Hive.box<AppSetting>(HiveBoxManager.settingBoxName);
    AppSetting setting = box.get(AppSetting.keyName)!;
    Log.out("HiveBox","HiveBoxManager.lastTheme(theme: ${setting.theme} ) ===");
    setting..theme = state.index;
    //box.put(AppSetting.keyName, setting);
    setting.save();
    Log.out("HiveBox","HiveBoxManager.updatedTheme(theme: ${setting.theme} ) ===");

    //box.close();

  }

  void updateLanguage(LangState lang) async {
    var box =  Hive.box<AppSetting>(HiveBoxManager.settingBoxName);
    AppSetting setting = box.get(AppSetting.keyName)!;
    Log.out("HiveBox","HiveBoxManager.lastLanguage(\ntheme: ${setting.language} ) ===");
    setting..language = lang.index;
    //box.put(AppSetting.keyName, setting);
    setting.save();
    Log.out("HiveBox","HiveBoxManager.updatedLanguage(\ntheme: ${setting.language} ) ===");

    //box.close();

  }

  void updateSettings(AppSetting appSettingData) async {
    //h.Box<AppSetting> box = await Hive.openBox<AppSetting>(HiveBoxManager.settingBoxName);
    appSettingData.save();
    //box.close();

  }
  
  Future<bool> addObject<T extends HiveObject >(
      {required T hiveObject, required String boxName}) async {
    
    var box = await Hive.openBox<T>(boxName);
    
    int value = await box.add(hiveObject);
    box.close();
    //if(value) return true;
    return false;
  }
  
  Future<bool> addMessage() async{
    return false;
  }

  @override
  void onUpdate() {
    Log.out("HiveBox"," HiveBoxManager.onUpdate() ===  ===");
  }
 



}


class DatabaseManager {

  Store? storeManager;

  //DatabaseManager();
  DatabaseManager.empty();
  DatabaseManager.initStore(){
    //this.storeManager = storeBox;

    this.openStoreBox().then((store) {
      final box = store.box<SettingAppData>();
      if(box.isEmpty()){
        final settingAppData = SettingAppData(
            createAt: new DateTime.now().toString(),
            os: Platform.operatingSystem,
            osVersion: Platform.operatingSystemVersion,
            phoneModel: 'SmartPhone not checked');
        final id = box.put(settingAppData);      // note: sets note.id and also returns it
        print("*** *** *** *** *** ***");
        print('new note got id=$id, which is the same as note.id=${settingAppData.id}');
        print('re-read note: ${box.get(id)}');
        print('Set tingAppData Added Once : ${box.get(id)?.toDisplay()} ###########');

      }
    });
  }

  Future<Store> openStoreBox() async {
    Directory dir = await getApplicationDocumentsDirectory();
    if(kIsWeb)
      return Store(getObjectBoxModel());
    return Store(getObjectBoxModel(), directory: dir.path + '/objectbox');
  }


  //Store? get storeManager => this._storeManager;


  /*SettingAppData initStoreBoxSetting(){
    final Store store =  openStoreBox();
    final box = store.box<SettingAppData>();

    if(box.isEmpty()){
      final settingAppData = SettingAppData(
          createAt: new DateTime.now().toString(),
          os: Platform.operatingSystem,
          osVersion: Platform.operatingSystemVersion,
          phoneModel: 'SmartPhone not checked');
      final id = box.put(settingAppData);      // note: sets note.id and also returns it

      print('new note got id=$id, which is the same as note.id=${settingAppData.id}');
      print('re-read note: ${box.get(id)}');
      print('Set tingAppData Added Once : ${box.get(id)?.toDisplay()} ###########');

    }
    var settingQuery = box.query().build();

    SettingAppData? settingData = settingQuery.findFirst();
    settingQuery.close();

    return settingData ?? SettingAppData();
  }*/

  Future<SettingAppData?> get getSettingDataBox async {
    Store store = await openStoreBox();
    //final box = store.box<SettingAppData>();
    final settingData = store.box<SettingAppData>()
        .query().build().findFirst();
    //settingData?..theme = themeState.index;
    //final id = box.put(settingData!, mode: PutMode.update);
    store.close();
    return settingData;
  }

  Future<bool> updateSettingData(SettingAppData settingAppData) async {
    bool value = false;
    Store store = await openStoreBox();
    final id = store.box<SettingAppData>()
        .put(settingAppData, mode: PutMode.update);
    if(id != settingAppData.id) value = true;
    store.close();
    return value;
  }


  Future<bool> updateTheme(StylesThemeState themeState) async {
    bool value = false;
    Store store = await openStoreBox();
    final box = store.box<SettingAppData>();
    final settingData = box.query().build().findFirst();
    settingData?..theme = themeState.index;
    final id = box.put(settingData!, mode: PutMode.update);
    if(id != settingData.id) value = true;

    store.close();
    return value;

  }

  Future<bool> updateLanguage(LangState langState) async {
    bool value = false;
    Store store = await openStoreBox();
    final box = store.box<SettingAppData>();
    final settingData = box.query(SettingAppData_.createAt.notNull())
        .build().findFirst();
    settingData?..language = langState.index;
    final id = box.put(settingData!, mode: PutMode.update);
    if(id != settingData.id) value = true;

    store.close();
    return value;

  }

  Future<bool> update_() async {
    bool value = false;
    Store store = await openStoreBox();

    store.close();
    return value;

  }
  Future<bool> add() async {
    bool value = false;
    Store store = await openStoreBox();

    store.close();
    return value;

  }
  Future<void> get_() async {
    bool value = false;
    Store store = await openStoreBox();

    store.close();


  }

}


  //final String _dbNameFile = 'exploress_db.db';
  //final int _dbVersion = 1;


  /*AppData? appData = AppData();
  UserData? userData;
  ProductData? productData;
  ShopData? shopData;
  LocationData? locationData;
  ReservationProduct? reservationProduct;

  DatabaseManager(){
    columnCount(AppData.getTableName).then((value) {
      print("DatabaseManager : Constructor --> AppData.count : $value === ===");
      *//*if(value == 0) {
        insertAppData(AppData(
          createAt: new DateTime.now().toString(),
          os: Platform.operatingSystem,
          osVersion: Platform.operatingSystemVersion,
          isFirstUse: 1,
        ));
        print('BD :  *** True => Insert Data ***');
      }
      else
        print('BD :  *** False => Insert Data ***');*//*

    });



   *//* if(firstUse())
      insertAppData(AppData(
        createAt: new DateTime.now(),
        os: Platform.operatingSystem,
        osVersion: Platform.operatingSystemVersion,
        isFirstUse: 1,
      ));
    else
      print('xxxxxxxxxxxxxxxx False xxxxxxxxxxxxxxxx');*//*
  }

  *//*static DatabaseManager init(){
    return DatabaseManager();
  }*//*


  *//*"CREATE TABLE ${appData.tableName}("
      "id INTEGER PRIMARY KEY,"
      ""
      ");"
   *//*

  DatabaseManager.init(){
    openDB();
  }


  /// Open Database
  Future<Database> openDB() async {
    final String? _dbFolder = await getDatabasesPath();
    if(! await Directory(_dbFolder!).exists()){
      await Directory(_dbFolder).create(recursive: true);
    }
    final dbPath = join(_dbFolder, _dbNameFile);
    final database = openDatabase(
        dbPath,
        version: _dbVersion,
        onCreate: (db, version) async {
          print('BD : onCreate => is calling');
          await db.execute(

            "CREATE TABLE ${appData?.tableName}("
                "id INTEGER PRIMARY KEY, "
                "first INTEGER NOT NULL, "
                "user_code TEXT, "
                "user_auth_state INTEGER NOT NULL, "
                "last_auth_check TEXT, "
                "theme INTEGER NOT NULL, "
                "language INTEGER NOT NULL, "
                "phone_name TEXT, "
                "phone_model TEXT, "
                "operatingSystem TEXT, "
                "operatingSystemVersion TEXT, "
                "email TEXT, "
                "location TEXT ,"
                "create_at TEXT "
                ");"


          );
          await  insertAppDataOnce(db,
              AppData(
              createAt: new DateTime.now().toString(),
              os: Platform.operatingSystem,
              osVersion: Platform.operatingSystemVersion,
              isFirstUse: 1,
          ));


        },
        onUpgrade: (Database db, int oldVersion, int newVersion){},
        onDowngrade: (Database db, int oldVersion, int newVersion){}

    );
    return database;
  }



  /// Insert data


  Future<void> clearAllData(String table) async {
    //final Database db = await openDB();

  }

  Future<int> columnCount(String table) async {
    final Database db = await openDB();
    int count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $table"))!;
    return count;
  }

  Future<void> insertAppDataOnce(
      final Database db, AppData appData) async {
    //final Database db = await openDB();
    await db.insert(
      appData.tableName,
      appData.asMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('AppData Added Once : ${appData.toString()} ###########');
    print('xxxxxxxxxxxxxxxx TRUE xxxxxxxxxxxxxxxx');
  }

  /// Insert App Data
  Future<void> insertAppData(AppData appData) async {
    final Database db = await openDB();
    await db.insert(
      appData.tableName,
      appData.asMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('AppData Added : ${appData.toString()} ###########');
    print('xxxxxxxxxxxxxxxx TRUE xxxxxxxxxxxxxxxx');
  }

  /// update App Data
  Future<bool> updateAppData(AppData appData,[String? key]) async {
    // Get a reference to the database.
    String where = 'id';
    appData.asMap().keys.forEach((element) {
      if(key == null) return;
      if(element == key) where = key;
    });
    if(key != null && where == 'id' ) return false;
    final db = await openDB();
    await db.update(
      appData.tableName,
      appData.asMap(),
      where: "$where = ?",
      whereArgs: [appData.id],
    );
    return true;
  }

  Future<bool> updateAppTheme(AppData appData,[String? key]) async {
    // Get a reference to the database.
    String where = 'id';
    appData.asMap().keys.forEach((element) {
      if(key == null) return;
      if(element == key) where = key;
    });
    if(key != null && where == 'id' ) return false;
    final db = await openDB();
    await db.update(
      appData.tableName,
      appData.asMap(),
      where: "$where = ?",
      whereArgs: [appData.id],
    );
    return true;
  }

  Future<void> changeToDarkTheme(bool v) async{
    int newTheme = (v)?0:1;
    final db = await openDB();
    await db.rawUpdate(
      *//*"""
        UPDATE APPDATA
        SET theme = ?
        WHERE theme = ?
       """,*//*
      'UPDATE APPDATA SET theme = ? WHERE id = ?',
      [newTheme],
    );
  }

  Future<void> updateAppThemeOnly(
      int newTheme,[int? lastTheme, bool? useReturn]
      ) async {

    final db = await openDB();
    await db.rawUpdate(
      *//*"""
        UPDATE APPDATA 
        SET theme = ? 
        WHERE theme = ?
       """,*//*
      """
        UPDATE APPDATA 
        SET theme = ? 
      """,
      [newTheme],
    );

    print("DatabaseManager : === UPDATE APPDATA THEME ===");
    //return true;
  }

  Future<bool> updateAppLanguage(AppData appData) async {
    // Get a reference to the database.
    *//*String where = 'id';
    appData.asMap().keys.forEach((element) {
      if(key == null) return;
      if(element == key) where = key;
    });
    if(key != null && where == 'id' ) return false;*//*
    final db = await openDB();
    await db.update(
      appData.tableName,
      appData.asMap(),
      where: "language = ?",
      whereArgs: [appData.id],
    );
    return true;
  }

  Future<void> updateAppLanguageOnly(int newLang, [int? lastLang]) async {
    *//**
     * French :
     * English :
     * Default Sys :
     * *//*
    final db = await openDB();
    await db.rawUpdate(
        """ 
        UPDATE APPDATA 
        SET language = ? 
        """,
        [newLang],
    );

    print("DatabaseManager : === UPDATE APPDATA LANGUAGE ===");
  }


  *//*AppData getAppDataOnly(){
    var map =
  }*//*


  /// Query AppData data
  Future<AppData> getAppData() async {
    int i = 0;
    final Database db = await openDB();
    //final List<Map<String, dynamic>> maps = await db.query('APPDATA');
    final List<Map<String, dynamic>> maps =
    await db.rawQuery('SELECT * FROM APPDATA');
    *//*return List.generate(maps.length, (i) {
      return AppData(
        id : maps[i]['id'],
        isFirstUse :maps[i]['is_first'],
        userCode :maps[i]['user_code'],
        email :maps[i]['email'],
        phoneName :maps[i]['phone_name'],
        phoneModel :maps[i]['phone_model'],
        os :maps[i]['operatingSystem'],
        osVersion :maps[i]['operatingSystemVersion'],
        theme :maps[i]['theme'],
        language :maps[i]['language'],
        userAuthState :maps[i]['user_auth_state'],
        lastAuthCheck :maps[i]['last_auth_check'],
        location :maps[i]['location'],
      );
    });*//*
    return AppData(
      id : maps[i]['id'],
      isFirstUse :maps[i]['is_first'],
      userCode :maps[i]['user_code'],
      email :maps[i]['email'],
      phoneName :maps[i]['phone_name'],
      phoneModel :maps[i]['phone_model'],
      os :maps[i]['operatingSystem'],
      osVersion :maps[i]['operatingSystemVersion'],
      theme : maps[i]['theme'],
      language :maps[i]['language'],
      userAuthState :maps[i]['user_auth_state'],
      lastAuthCheck :maps[i]['last_auth_check'],
      location :maps[i]['location'],
    );
  }*/

/*
  /// Insert data
  Future<void> insertUser(Student student) async {
    final Database db = await openDB();
    await db.insert(
      'students',
      student.asMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  /// Insert data
  Future<void> insertShop(Student student) async {
    final Database db = await openDB();
    await db.insert(
      'students',
      student.asMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  /// Insert data
  Future<void> insertProduct(Student student) async {
    final Database db = await openDB();
    await db.insert(
      'students',
      student.asMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Query data
  Future<List<Student>> queryStudents() async {
    final Database db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query('students');
    return List.generate(maps.length, (i) {
      return Student(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['age'],
      );
    });
  }

  /// update data
  Future<void> updateStudent(Student student) async {
    // Get a reference to the database.
    final db = await openDB();
    await db.update(
      'students',
      student.asMap(),
      where: "id = ?",
      whereArgs: [student.id],
    );
  }

  /// delete data
  Future<void> deleteStudent(int id) async {
    final db = await openDB();
    await db.delete(
      'students',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> insertStudent(Student student) async {
    final Database db = await openDB();
    await db.insert(
      'students',
      student.asMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }*/




/*"CREATE TABLE ${userData.tableName}("
                    "id INTEGER PRIMARY KEY, "
                    "name TEXT, "
                    "user_code TEXT, "
                    "phone_number TEXT, "
                    "email TEXT, "
                    "location TEXT "
                "), "

                "CREATE TABLE ${shopData.tableName}("
                    "id INTEGER PRIMARY KEY, "
                    "shop_name TEXT, "
                    "shop_code TEXT, "
                    "phone_number TEXT, "
                    "open_day TEXT, "
                    "is_opened INTEGER, "
                    "email TEXT, "
                    "location TEXT "
                "), "

                "CREATE TABLE ${productData.tableName}("
                    "id INTEGER PRIMARY KEY, "
                    "product_name TEXT, "
                    "price INTEGER"
                    "promotion_price INTEGER, "
                    "promotion_outdate TEXT, "
                    "category TEXT, "
                    "sub_category TEXT, "
                    "stock_number INTEGER, "
                    "is_possible TEXT, "
                    "shop_code TEXT, "
                "), "

                "CREATE TABLE ${locationData.tableName}("
                    "id INTEGER PRIMARY KEY, "
                    "name TEXT, "
                    "age INTEGER"
                "), "
                "CREATE TABLE ${reservationProduct.tableName}("
                    "id INTEGER PRIMARY KEY, "
                    "user_code TEXT, "
                    "product_code TEXT, "
                    "age INTEGER"
                "), "
                "",*/