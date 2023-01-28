

import 'package:exploress/pages/home_page.dart';
import 'package:exploress/pages/login/signup_and_login.dart';
import 'package:exploress/pages/settings_and_about/about.dart';
import 'package:exploress/pages/settings_and_about/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';




class RouteManager {
  //@Deprecated("use Go.to() instead ")
  static Future<T?>? goto<T>(BuildContext context, {
    required Widget page,
    required String routeName,
    dynamic args,
  }){
    if(!kIsWeb){
      //Navigator.of(context).push(route);
      return Navigator.push(context,
          MaterialPageRoute<T>(builder: (_) => page,
              settings: RouteSettings(
                arguments: args,
              )
          )
      );
      //Get.to(() => page);
    } else{
      return Navigator.pushNamed<T>(context, routeName,arguments: args,);
      //Get.toNamed(routeName);
    }
  }

  /*static void to(BuildContext context, {
    required Widget page,
    required String routeName,
    dynamic args,}){
    return goto(context, page: page, routeName: routeName, args: args);
  }*/
  static final kRoutes = <String, WidgetBuilder>{
    HomePage.routeName         : (context) => const HomePage(),
    LoginPage.routeName        : (context) => const LoginPage(),
    AboutPage.routeName        : (context) => const AboutPage(),
    SettingPage.routeName      : (context) => const SettingPage(),
    //AddProductScreen.routeName : (context) => const AddProductScreen(),
    //ChatPage.routeName         : (context) => const ChatPage(),
    //MessagesPage.routeName     : (context) => const MessagesPage(),

  };
}

class Go {

  static Future<T?>? to<T>(BuildContext context,{
    required Widget page,
    required String routeName,
    dynamic args,
  }){
    return RouteManager.goto<T>(context, page: page, routeName: routeName);
  }
}