import 'package:hive/hive.dart';

part 'AppSettingModel.g.dart';

@HiveType(typeId: 0)
class AppSetting extends HiveObject {

  static const keyName = "settingTest";

  @HiveField(0)
  int? id;

  @HiveField(1)
  int? theme;

  @HiveField(2)
  int? language;

}
