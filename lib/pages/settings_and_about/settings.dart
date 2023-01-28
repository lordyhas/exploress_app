import 'package:exploress/data/app_database.dart';
import 'package:exploress/data/app_bloc_library.dart';
import 'package:exploress/data/values.dart';
import 'package:exploress/pages/login/signup_and_login.dart';
import 'package:exploress/pages/profiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:package_info/package_info.dart';

import 'about.dart';

class SettingPage extends StatefulWidget {
  static const routeName = "/home/settings";

  const SettingPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SettingPage());
  }

  @override
  _SettingState createState() {
    return _SettingState();
  }
}

class _SettingState extends State<SettingPage> {
  bool notifyValue = false;
  bool syncValue = false;
  bool darkModeValue = false;
  bool onLangChange = false;

  List<String> languageList = [
    'English',
    'Français',
    'Default'
  ]; // 'Lingala', 'Kiswahili'];
  var text;

  //DatabaseManager obm = new DatabaseManager.empty();
  HiveBoxManager hiveBoxManager = HiveBoxManager();

  String? version;
  String? buildNumber;

  late String dropdownValue;

  int selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    selectedIndex =
        BlocProvider.of<LanguageBloc>(context).state.currentLangState.index;
    darkModeValue = BlocProvider.of<StyleAppTheme>(context).state.brightness ==
        Brightness.dark;
    initPlatform();
    initObjectBox();
  }

  initPlatform() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //String appName = packageInfo.appName;
    //String packageName = packageInfo.packageName;
    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  void initObjectBox() async {
    //final _data = (await obm.getSettingDataBox)!;
    setState(() {
      notifyValue = true; //_data.isNotificationOn!;
      syncValue = true; //_data.isSync!;
      //darkModeValue = false;
      //onLangChange = false;
    });
  }

  Future<dynamic> info() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

  void _setSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: context.read<StyleAppTheme>().state.brightness,
      systemNavigationBarColor:
          context.read<StyleAppTheme>().state.primaryColor,
    ));
  }

  Future<bool> _willPop() {
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    text = context.read<LanguageBloc>().state.getStrings();
    languageList[2] = text['default'];
    Color iconColor = Colors.blue;

    ///Color iconColor = Theme.of(context).accentColor; // Todo: version 0.3.5

    TextStyle textStyleSet = Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(fontSize: 17, fontWeight: FontWeight.bold);
    //TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    final TextStyle textStyleBet = TextStyle(color: iconColor, fontSize: 18);

    dropdownValue = languageList[0];
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          /*leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, HomePage.route(), (route) => false);
                    //Navigator.defaultRouteName;
                    //Navigator.pop(context);
                  }
                ),*/
          title: Text(text['setting_name']),
        ),
        body: ListView(
          padding: EdgeInsets.all(4.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                text['setting_pref'],
                //"Préférence",
                style: textStyleBet,
              ),
            ),
            Card(
              //color: Colors.white54,
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: iconColor,
                    ),
                    title: Text(text['my_account'], style: textStyleSet),
                    trailing: const Icon(Icons.arrow_right),
                    onTap: () {
                      switch (BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .status) {
                        case AuthenticationStatus.authenticated:
                          /*_setSystemUIOverlayStyle();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                        new ProfilePage()));*/
                          Navigator.pushReplacement(
                              context, ProfilePage.route());

                          break;
                        case AuthenticationStatus.unauthenticated:
                        case AuthenticationStatus.unknown:
                          Navigator.pushReplacement(context, LoginPage.route());
                          //Navigator.pushAndRemoveUntil(
                          //context, LoginPage.route(), (route) => true);
                          break;
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      (darkModeValue) ? Icons.brightness_3 : Icons.brightness_5,
                      color: iconColor,
                    ),
                    title: Text("Theme Mode", style: textStyleSet),
                    subtitle: Text(
                        (darkModeValue) ? "Dark Mode ON" : "Dark Mode OFF"),
                    trailing: Switch(
                        activeColor: Theme.of(context).primaryColor,
                        value: darkModeValue,
                        onChanged: (v) {
                          setState(() {
                            darkModeValue = !darkModeValue;
                          });
                          /**setState(() {
                              darkModeValue = !darkModeValue;
                              if(darkModeValue)
                              obm.updateTheme(StylesThemeState.dark);
                              else obm.updateTheme(StylesThemeState.light);
                              });*/
                          // BlocProvider.of();

                          /// Toggle Theme
                          BlocProvider.of<StyleAppTheme>(context).toggleTheme();
                          _setSystemUIOverlayStyle();
                        }),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.language,
                      color: iconColor,
                    ),
                    title: Text(text['set_lang'], style: textStyleSet),
                    subtitle: Text(
                      languageList[BlocProvider.of<LanguageBloc>(context)
                          .state
                          .currentLangState
                          .index],
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => Container(
                                height: 420,
                                child: SimpleDialog(
                                  title: Text(
                                    text['choose_lang'],
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  children: List<Widget>.generate(
                                      languageList.length, (index) {
                                    return RadioListTile(
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        title: Text(
                                          languageList[index],
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        value: index,
                                        groupValue: selectedIndex,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedIndex = value as int;
                                          });

                                          BlocProvider.of<LanguageBloc>(context)
                                              .switchLang(LangState
                                                  .values[selectedIndex]);
                                          //obm.updateLanguage(LangState.values[selectedIndex]);
                                          Navigator.pop(context);

                                          //_callback(selectedIndex);
                                        });
                                  }),
                                ),
                              ));
                    },
                    //subtitle: Text(dropdownValue),

                    /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(text['set_lang'], style: textStyleSet),
                              Container(
                                width: 100,
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  isExpanded: true,
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                   if(dropdownValue.contains(languageList[0])){
                                     context.bloc<LanguageBloc>().switchLang(LangState.en);
                                   }

                                    if(dropdownValue.contains(languageList[1])){
                                      context.bloc<LanguageBloc>().switchLang(LangState.fr);
                                      setState(() {
                                        dropdownValue = languageList[1];
                                      });
                                    }
                                    if(dropdownValue.contains(languageList[2])){
                                      context.bloc<LanguageBloc>().switchLang(LangState.en);
                                      setState(() {
                                        dropdownValue = languageList[2];
                                      });
                                    }
                                    //context.bloc<LanguageBloc>().toggleLangEnToFr();
                                  },
                                  items: languageList.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),*/

                    trailing: null,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.add_circle_outline,
                      color: iconColor,
                    ),
                    title: Text(text['set_contrib'], style: textStyleSet),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Sorry",
                                  style: Theme.of(context).textTheme.bodyText2),
                              content: Text(
                                  "Oups! this functionality is not available in your region"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Remember me when',
                                        style: TextStyle(color: iconColor))),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel',
                                        style: TextStyle(color: iconColor))),
                              ],
                            )),
                  ),
                ],
              ),
            ),

            /// Synchronisation ######
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                text['set_sync_title'],
                style: textStyleBet,
              ),
            ),
            Card(
              //color: Colors.white54,
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      (syncValue) ? Icons.sync : Icons.sync_disabled,
                      color: (syncValue) ? iconColor : Colors.grey[700],
                    ),
                    title: Text("Sync", style: textStyleSet),
                    trailing: Switch(
                        activeColor: Theme.of(context).primaryColor,
                        value: syncValue,
                        onChanged: (v) {
                          setState(() {
                            syncValue = !syncValue;
                          });
                        }),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.mail,
                      color: (syncValue) ? iconColor : Colors.grey[700],
                    ),
                    title: Text("Sync with Mail", style: textStyleSet),
                    trailing: Icon(
                        (!syncValue) ? Icons.do_not_disturb_alt : Icons.done),
                    onTap: (!syncValue) ? null : () {},
                  ),
                  CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    value: notifyValue,
                    onChanged: (v) {
                      setState(() {
                        notifyValue = !notifyValue;
                      });
                    },
                    title: Text("Notification", style: textStyleSet),
                    secondary: Icon(
                      (notifyValue)
                          ? Icons.notifications
                          : Icons.notifications_off,
                      color: (notifyValue) ? iconColor : Colors.grey[700],
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.location_on,
                      color: iconColor,
                    ),
                    title: Text("Address & Location", style: textStyleSet),
                    trailing: const Icon(Icons.arrow_right),
                  )
                ],
              ),
            ),

            /// About ### ###
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                text['set_about_title'],
                style: textStyleBet,
              ),
            ),
            Card(
              //color: Colors.white54,
              elevation: 4.0,
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(text['about_exploress'], style: textStyleSet),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage(
                                title: "A propos de l'unh",
                                bodyChild: AboutUnhWidget(),
                              )
                          ),
                        );*/
                      },
                    ),
                    ListTile(
                      title: Text(
                        text['about_exploress_app'],
                        style: textStyleSet,
                      ),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        SystemChrome.setSystemUIOverlayStyle(
                            SystemUiOverlayStyle(
                          systemNavigationBarColor:
                              Theme.of(context).scaffoldBackgroundColor,
                        ));
                        Navigator.push(
                            context, AboutPage.route(isSystemSet: true));
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Version",
                        style: textStyleSet,
                      ),
                      subtitle: Text(
                        "non-stable : $version  ",
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            )
          ],
        ),
      ),
    );
  }
}
