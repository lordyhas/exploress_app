import 'dart:async';


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploress/data/app_bloc_library.dart';
import 'package:exploress/data/app_database.dart';
import 'package:exploress/data/database/model/setting_data.dart';
import 'package:exploress/data/map_data/gps_location.dart';
import 'package:exploress/data/values.dart';
import 'package:exploress/pages/product/single_product_page.dart';
import 'package:exploress/pages/profiles.dart';
import 'package:exploress/pages/product/quick_single_product.dart';
import 'package:exploress/pages/settings_and_about/About.dart';
import 'package:exploress/pages/settings_and_about/Settings.dart';
import 'package:exploress/pages/shop/filters_screen.dart';
import 'package:exploress/pages/splash_page.dart';
import 'package:exploress/widget_model/BooleanBuilder.dart';
import 'package:exploress/widget_model/PageViewAnim.dart';
import 'package:exploress/widgets.dart';
import 'package:exploress_repository/exploress_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:utils_component/utils_component.dart';
import 'package:shimmer/shimmer.dart';

import 'login/signup_and_login.dart';


part 'home_page/HomeAppBar.dart';
part 'home_page/HomeDrawerView.dart';
part 'home_page/HomeScreen.dart';


class HomePage extends StatefulWidget  {
  HomePage({Key? key,}) : super(key: key);

  static Route route() {
    //if(kIsWeb) return MaterialPageRoute<void>(builder: (_) => HomePage());
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> with WidgetsBindingObserver{
  String? appBarBackgroundImage;
  var text;
  final FirebaseManager firebaseManager = FirebaseManager();
  final DatabaseManager objectBoxManager = DatabaseManager.empty();

  @override
  void initState() {
    //print('###### initState(HOME-PAGE) #######');
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies xxx xxx xxx xxx");
    _uploadUserInCloud();
    _checkSomePermissions();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive === === === ===');
        break;
      case AppLifecycleState.resumed:
        print('appLifeCycleState resumed === === === ===');
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused === === === ===');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState suspending ======================');
        break;
    }
  }

  void _initPosition() async {
    //GPSLocation.myCurrentPosition();
    Future.delayed(Duration(seconds: 5));
    BlocProvider.of<MapsBloc>(context).load(
        position: await GPSLocation.myCurrentPosition(),
    );
    Log.out('GPSLocation', '_initPosition(Current position set)');

    //Timer.periodic(Duration(seconds: 5), (timer) {});

  }

  void _checkSomePermissions() async {
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }

    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      //Permission.camera,
      //Permission.locationAlways,
    ].request();
    print("storage Permission :"+statuses[Permission.storage].toString());
  }

  /*_uploadUserInCloud() async {
    if (BlocProvider.of<AuthenticationBloc>(context).state.status ==
        AuthenticationStatus.authenticated) {
      User user = context.read<AuthenticationBloc>().state.user;
      print(user);

      var avatar = (await NetworkAssetBundle(Uri.parse(user.photoMail!))
          .load(user.photoMail!))
          .buffer
          .asUint8List();

      firebaseManager.addUserInCloud(
        user: user.copyWith(
          photoCloud: Blob(avatar),
        ),
      );

      User userUploaded = await firebaseManager.getUserInCloud(userId: user.id);
      context.read<AuthenticationBloc>().updateUser(userUploaded);
    }
  }*/

  /*void _initObjectBox() async {
    //_store = await objectBoxManager.openStoreBox();
    final SettingAppData _settingData = (await objectBoxManager.getSettingDataBox)!;
    //print(" ObjectBox._initObjectBox(theme: ${_settingData!.theme}) ===  ===");
    context
        .read<LanguageBloc>()
        .switchLang(LangState.values[_settingData.language]);
    context
        .read<StyleAppTheme>()
        .setTheme(StylesThemeState.values[_settingData.theme]);
  }*/

  _uploadUserInCloud() async {
    if (BlocProvider.of<AuthenticationBloc>(context).state.status ==
        AuthenticationStatus.authenticated) {
      //User user = context.watch<AuthenticationBloc>().state.user;
      User user = BlocProvider.of<AuthenticationBloc>(context).state.user;
      print('AuthenticationBloc(context.state.user) => $user ==== ====');


      if ( true/*user.photoMail != null*/) {
        var avatar = (await NetworkAssetBundle(Uri.parse(user.photoMail!))
            .load(user.photoMail!))
            .buffer
            .asUint8List();
        print('Write Report => FirebaseManager.uploadUserInCloud(context)'
            ' : write document in Firestore ### ###');
        firebaseManager.addUserInCloud(
          user: user.copyWith(
            photoCloud: Blob(avatar),
          ),
        );
      }
      //else firebaseManager.addUserInCloud(user: user);
      //Future.delayed(Duration(seconds: 2));

      User userUploaded = await firebaseManager.getUserInCloud(userId: user.id);

      //context.read<AuthenticationBloc>().updateUser(userUploaded);
      if (userUploaded != User.empty) {
        print(
            'Read Report => FirebaseManager.uploadUserInCloud(context)'
                ' : read doc in Firestore ### ###');
        BlocProvider.of<AuthenticationBloc>(context).updateUser(userUploaded);
        //context.read<AuthenticationBloc>().updateUser(userUploaded);

      }

    }
  }


  @override
  Widget build(BuildContext context) {
    _initPosition();

    return HomeScreen();
  }

//Drawer drawer = drawerWidget();
}



