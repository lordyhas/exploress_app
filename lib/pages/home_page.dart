import 'dart:async';


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploress/data/app_bloc_library.dart';

import 'package:exploress/data/map_data/gps_location.dart';
import 'package:exploress/data/values.dart';
import 'package:exploress/pages/product/single_product_page.dart';
import 'package:exploress/pages/profiles.dart';
import 'package:exploress/pages/product/quick_single_product.dart';
import 'package:exploress/pages/settings_and_about/about.dart';
import 'package:exploress/pages/settings_and_about/settings.dart';
import 'package:exploress/pages/shop/filters_screen.dart';
import 'package:exploress/pages/shop_page.dart';
import 'package:exploress/pages/splash_page.dart';

import 'package:exploress/widgets.dart';
import 'package:exploress_repository/exploress_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:utils_component/utils_component.dart';
import 'package:shimmer/shimmer.dart';

import 'package:exploress/pages/login/signup_and_login.dart';


part 'home_page/HomeAppBar.dart';
part 'home_page/HomeDrawerView.dart';
part 'home_page/home_screen.dart';


class HomePage extends StatefulWidget  {
  static const routeName = "/home";
  const HomePage({Key? key,}) : super(key: key);

  static Route route() {
    //if(kIsWeb) return MaterialPageRoute<void>(builder: (_) => HomePage());
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> with WidgetsBindingObserver{
  String? appBarBackgroundImage;
  var text;
  final FirebaseManager firebaseManager = FirebaseManager();
  //final DatabaseManager objectBoxManager = DatabaseManager.empty();

  @override
  void initState() {
    //print('###### initState(HOME-PAGE) #######');
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("didChangeDependencies xxx xxx xxx xxx");
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
        if (kDebugMode) {
          print('appLifeCycleState inactive === === === ===');
        }
        break;
      case AppLifecycleState.resumed:
        if (kDebugMode) {
          print('appLifeCycleState resumed === === === ===');
        }
        break;
      case AppLifecycleState.paused:
        debugPrint('appLifeCycleState paused === === === ===');
        break;
      case AppLifecycleState.detached:
        debugPrint('appLifeCycleState suspending ======================');
        break;
    }
  }

  void _initPosition() async {
    //GPSLocation.myCurrentPosition();
    Future.delayed(const Duration(seconds: 5));
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
    debugPrint("storage Permission :"+statuses[Permission.storage].toString());
  }


  void _uploadUserInCloud() async {
    if (BlocProvider.of<AuthenticationBloc>(context).state.status ==
        AuthenticationStatus.authenticated) {
      //User user = context.watch<AuthenticationBloc>().state.user;
      User user = BlocProvider.of<AuthenticationBloc>(context).state.user;
      debugPrint('AuthenticationBloc(context.state.user) => $user ==== ====');


      if ( true/*user.photoMail != null*/) {
        var avatar = (await NetworkAssetBundle(Uri.parse(user.photoMail!))
            .load(user.photoMail!))
            .buffer
            .asUint8List();
        debugPrint('Write Report => FirebaseManager.uploadUserInCloud(context)'
            ' : write document in Firestore ### ###');
        firebaseManager.addUserInCloud(
          user: user.copyWith(
            photoCloud: Blob(avatar),
          ),
        );
      }

      User userUploaded = await firebaseManager.getUserInCloud(userId: user.id);

      if (userUploaded != User.empty) {
        debugPrint(
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

    return const HomeScreen();
  }

//Drawer drawer = drawerWidget();
}



