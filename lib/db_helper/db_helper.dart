import 'dart:convert';
import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../screen/survey/model/apsco_saving_model.dart';
import '../screen/survey/model/epsco_question_list_model.dart';
import '../screen/survey/model/image_model_class_for_gcs.dart';
import '../screen/survey/model/sys_epsco_survey_questions.dart';
import 'db_constant.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  // Public getter to get the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(); // Create and initialize DB if not already
    return _database!;
  }

  // Internal function to initialize DB and create table
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'survey_db.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print("Creating table: ${DbConstant.sysTableEpscoQuestion}");
        await db.execute('''
          CREATE TABLE ${DbConstant.sysTableEpscoQuestion} (
            ${DbConstant.id} INTEGER PRIMARY KEY UNIQUE,
            ${DbConstant.sysSurveyEnQuestion} TEXT,
            ${DbConstant.sysSurveyArQuestion} TEXT,
            ${DbConstant.sysSurveyAnswerType} TEXT,
            ${DbConstant.sysOnYesGetValue} TEXT,
            ${DbConstant.sysSurveySkuImage} TEXT,
            ${DbConstant.sysOnYesGetImage} TEXT
          )
        ''');

        await db.execute('CREATE TABLE '
            ' ${DbConstant.transTableEpscoAnswer}'
            ' (${DbConstant.id} INTEGER,'
            ' ${DbConstant.transFirstAnswer} TEXT,'
            ' ${DbConstant.transSecondAnswer} TEXT,'
            ' ${DbConstant.transImageName} TEXT, '
            ' ${DbConstant.gcsStatus} INTEGER,'
            ' ${DbConstant.uploadStatus} INTEGER,'
            ' CONSTRAINT unique_key UNIQUE (${DbConstant.id},'
            ' ${DbConstant.id}))');
      },
    );
  }

  // Gtc Array Bulk Insert
  static Future<bool> insertSysEpscoQuestionArray(
      List<SysEpscoSurveyQuestionModel> modelList) async {
    var db = await DatabaseHelper().database;
    List<String> valueList = [];

    for (SysEpscoSurveyQuestionModel data in modelList) {
      bool isDuplicate = await hasDuplicateEntry(
        db,
        DbConstant.sysTableEpscoQuestion,
        {DbConstant.id: data.id},
      );
      if (!isDuplicate) {
        String value =
            '("${data.id}", "${data.sysSurveyEnQuestion}", "${data.sysSurveyArQuestion}", '
            '"${data.sysSurveyAnswerType}", "${data.sysOnYesGetValue}","${data.skuImage}", '
            '"${data.sysOnYesGetImage}")';
        valueList.add(value);
      } else {
        print("Duplicate entry for ID ${data.id} — skipping.");
      }
    }

    if (valueList.isNotEmpty) {
      String values = valueList.join(',');
      String sql = '''
        INSERT OR REPLACE INTO ${DbConstant.sysTableEpscoQuestion} (
          ${DbConstant.id},
          ${DbConstant.sysSurveyEnQuestion},
          ${DbConstant.sysSurveyArQuestion},
          ${DbConstant.sysSurveyAnswerType},
          ${DbConstant.sysOnYesGetValue},
          ${DbConstant.sysSurveySkuImage},
          ${DbConstant.sysOnYesGetImage}
        ) VALUES $values
      ''';

      await db.rawInsert(sql);
      print('Bulk insert completed successfully.');
      return true;
    } else {
      print('No new data to insert.');
      return false;
    }
  }




  static Future<List<EpscoSurveyListData>> getGtcSurveyDataList() async {
    final db =  await DatabaseHelper().database;
    String rawQuery = 'SELECT * FROM trans_epsco_answers '
        ' JOIN sys_epsco_questions ON sys_epsco_questions.id = trans_epsco_answers.id';

    final List<Map<String, dynamic>> gtcSurveyMap = await db.rawQuery(rawQuery);
    print('Epsco Survey Querys');
    log(rawQuery);
    log(jsonEncode(gtcSurveyMap));
    return List.generate(gtcSurveyMap.length, (index) {
      return EpscoSurveyListData(
        id: gtcSurveyMap[index]['id'],
        sysSurveyEnQuestion: gtcSurveyMap[index]['en_question'] ?? "",
        sysSurveyArQuestion: gtcSurveyMap[index]['ar_question'] ?? "",
        sysOnYesGetImage: gtcSurveyMap[index]['on_yes_get_image'] ?? "",
        sysOnYesGetValue: gtcSurveyMap[index]['on_yes_get_value'] ?? "",
        sysSurveyAnswerType: gtcSurveyMap[index]['answer_type'] ?? "",
        transFirstAnswer: gtcSurveyMap[index]['answer_first'] ?? "",
        transSecondAnswer: gtcSurveyMap[index]['answer_second'] ?? "",
        transImageName: gtcSurveyMap[index]['answer_images_name'] ?? "",
        uploadStatus: gtcSurveyMap[index]['upload_status'] ?? 0,
        gcsStatus: gtcSurveyMap[index]['gcs_status'] ?? 0,
          skuImage: gtcSurveyMap[index]['sku_img'] ?? ""
      );
    });
  }
  ///Gtc Single Survey Question Details
  static Future<EpscoSurveyListData> getEpscoSurveySingleQuestionData(int questionId) async {
    final db =await DatabaseHelper().database;
    String rawQuery = 'SELECT * FROM trans_epsco_answers '
        ' JOIN sys_epsco_questions ON sys_epsco_questions.id = trans_epsco_answers.id WHERE sys_epsco_questions.id=$questionId';

    final List<Map<String, dynamic>> gtcSurveyMap = await db.rawQuery(rawQuery);
    print('GTC Survey Types List QUERY   $questionId');
    log(rawQuery);
    print('GTC Survey Types List');
    log(jsonEncode("asdasd  $gtcSurveyMap"));
    return EpscoSurveyListData(
      id: gtcSurveyMap[0]['id'],
      sysSurveyEnQuestion: gtcSurveyMap[0]['en_question'] ?? "",
      sysSurveyArQuestion: gtcSurveyMap[0]['ar_question'] ?? "",
      sysOnYesGetImage: gtcSurveyMap[0]['on_yes_get_image'] ?? "",
      sysOnYesGetValue: gtcSurveyMap[0]['on_yes_get_value'] ?? "",
      sysSurveyAnswerType: gtcSurveyMap[0]['answer_type'] ?? "",
      transFirstAnswer: gtcSurveyMap[0]['answer_first'] ?? "",
      transSecondAnswer: gtcSurveyMap[0]['answer_second'] ?? "",
      transImageName: gtcSurveyMap[0]['answer_images_name'] ?? "",
      uploadStatus: gtcSurveyMap[0]['upload_status'] ?? 0,
      gcsStatus: gtcSurveyMap[0]['gcs_status'] ?? 0,
      skuImage: gtcSurveyMap[0]['sku_img'] ?? ""

    );
  }

  static Future<int> updateGtcSurveyItem(String apscoSurveyId,int gcsStatus,String answerOption,String answer2,String imageName) async {
    String writeQuery = 'UPDATE trans_epsco_answers SET answer_first=${wrapIfString(answerOption)},'
        ' answer_images_name=${wrapIfString(imageName)},answer_second=${wrapIfString(answer2)},'
        ' gcs_status=$gcsStatus,upload_status=0  WHERE id = $apscoSurveyId ';

    var db = await DatabaseHelper().database;
    print('_______________UpdATE Trans Gtc ________________');
    print(writeQuery);
    return await db.rawUpdate(writeQuery);
  }
  static Future<int> insertTransEpscoSurvey(String storeId) async {
    String insertQuery = 'INSERT OR IGNORE INTO trans_epsco_answers (id, answer_images_name,answer_first,answer_second, gcs_status, upload_status) '
        ' SELECT sys_epsco_questions.id,"","","",0, 0'
        ' FROM sys_epsco_questions';
    var db =  await DatabaseHelper().database;
    print('_______________INSERT Trans GTC ________________');
    print(insertQuery);
    return await db.rawInsert(insertQuery);
  }


  ///get Gtc Images For GCS upload
  static Future<List<TransGcsImagesListModel>> getApscoSurveyGcsImagesList() async {
    var db =  await DatabaseHelper().database;
    String rawQuery = 'SELECT id, answer_images_name '
        ' FROM trans_epsco_answers WHERE gcs_status=0 AND answer_images_name!= ""';

    final List<Map<String, dynamic>> surveyMap = await db.rawQuery(rawQuery);

    print('GTC Survey QUERY');
    print(rawQuery);
    print(surveyMap);

    return List.generate(surveyMap.length, (index) {
      return TransGcsImagesListModel(
          id: surveyMap[index]['id'],
          imageName: surveyMap[index]['answer_images_name'],
          imageFile: null
      );
    });
  }

  ///Update GTC survey after Image upload
  static Future<int> updateApcsoSurveyAfterGcsAfterFinish(int id) async {

    String writeQuery = 'UPDATE trans_epsco_answers SET gcs_status=1 WHERE id=$id';

    var db =  await DatabaseHelper().database;

    print('_______________UpdATE General Survey After GCS________________');
    print(writeQuery);

    return await db.rawUpdate(writeQuery);

  }

  ///Get Data for APi Upload
  static Future<List<ApscoSurveyRequestData>> getActivityStatusApscoSurveyDataList() async {
    var db =  await DatabaseHelper().database;
    String rawQuery = 'SELECT * '
        ' FROM trans_epsco_answers WHERE upload_status=0';

    print('Trans Gtc Survey QUERY');
    print(rawQuery);

    final List<Map<String, dynamic>> surveyMap = await db.rawQuery(rawQuery);
    print(surveyMap);
    return List.generate(surveyMap.length, (index) {
      return ApscoSurveyRequestData(
          questionId: surveyMap[index]['id'],
          answerRadio: surveyMap[index]['answer_first'].toString(),
          imageNames: surveyMap[index]['answer_images_name'].toString(),
          answerText: surveyMap[index]['answer_second'].toString()
      );
    });
  }

  ///Update Db After API
  static Future<int> updateApscoSurveyAfterApi(String ids) async {
    String writeQuery = 'UPDATE trans_epsco_answers SET upload_status=1 WHERE id in ($ids)';

    var db =  await DatabaseHelper().database;
    print('_______________UpdATE General Survey ________________');
    print(writeQuery);

    return await db.rawUpdate(writeQuery);
  }


  static Future<void> closeDb(String dbPath) async {

    Database db = await openDatabase(dbPath);
    if(db.isOpen) {
      await db.close();
      print('Compiler is HERE ${db.isOpen}');
    }
  }
  //----******** delete tabale********------------
  static Future<void> delete_table(String tbl_name) async {
    var db = await DatabaseHelper().database;
    await db.rawDelete('DELETE FROM $tbl_name');
  }
  // Check for duplicate entry
  static Future<bool> hasDuplicateEntry(
      Database db, String DbConstant, Map<String, dynamic> fields) async {
    final whereClause = fields.keys.map((key) => '$key = ?').join(' AND ');
    final whereArgs = fields.values.toList();
    final result = await db.query(
      DbConstant,
      where: whereClause,
      whereArgs: whereArgs,
    );
    return result.isNotEmpty;
  }
}
String wrapIfString(dynamic value) {
  if (value is String) {
    return '"$value"';
  } else {
    return value.toString();
  }
}