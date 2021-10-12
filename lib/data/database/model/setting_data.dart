
import 'package:objectbox/objectbox.dart';

@Entity()
class SettingAppData{
  bool? isNotificationOn;
  bool? isSync;
  bool? isSyncWithMail;
  @Transient()
  DateTime now = DateTime.now();
  int id = 0;
  String? phoneName;
  String? userCode;
  String? phoneModel;
  String? os;
  String? osVersion;
  String? email;
  int theme;
  int language;
  int? userAuthState;
  String? lastAuthCheck;
  String? location;
  String? createAt;

  SettingAppData({
    this.isNotificationOn = true,
    this.isSync = false,
    this.isSyncWithMail = false,
    this.createAt,
    this.phoneName,
    this.userCode,
    this.phoneModel = "",
    this.email,
    this.location,
    this.os,
    this.osVersion,
    this.theme = 0,
    this.language = 1,
    this.userAuthState = 0,
    this.lastAuthCheck,
  }) ;




  toDisplay() {
    var map = {
    'id': this.id,
    'user_code': this.userCode,
    'email': this.email,
    'phone_name': this.phoneName,
    'phone_model': this.phoneModel,
    'operatingSystem': this.os,
    'operatingSystemVersion':this.osVersion,
    'theme': this.theme,
    'language': this.language,
    'user_auth_state': this.userAuthState,
    'last_auth_check': this.lastAuthCheck,
    'location': this.location,
    'create_at': this.createAt,
    };
    print("*** \n${this.toString()}{");

    map.forEach((key, value) => print("$key : $value,"));
    print('} \n***');
  }
  /*//@override
  Map<String, dynamic> asMap() => {
    'id': id,
    'user_code': userCode,
    'email': email,
    'phone_name': phoneName,
    'phone_model': phoneModel,
    'operatingSystem': os,
    'operatingSystemVersion': osVersion,
    'theme': theme,
    'language': language,
    'user_auth_state': userAuthState,
    'last_auth_check': lastAuthCheck,
    'location': location,
    'create_at': createAt,
  };*/



  /*SettingAppData copyWith({
    //id,
    int? isFirstUse,
    String? phoneName,
    String? userCode,
    String? phoneModel,
    String? os,
    String? osVersion,
    String? email,
    int? theme,
    int? language,
    int? userAuthState,
    lastAuthCheck,
    location,}) {
    return  SettingAppData(
      //id: id ?? this.id,
      phoneName: phoneName ?? this.phoneName,
      userCode: userCode?? this.userCode,
      phoneModel: phoneModel ?? this.phoneModel,
      os: os ?? this.os,
      osVersion: osVersion ?? this.osVersion,
      email: email ?? this.email,
      theme: theme ?? this.theme,
      language: language ?? this.language,
      userAuthState: userAuthState ?? this.userAuthState,
      lastAuthCheck: lastAuthCheck ?? this.lastAuthCheck,
      location: location ?? this.location,
    );
  }*/



}
