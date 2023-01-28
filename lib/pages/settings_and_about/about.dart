import 'dart:io';

import 'package:exploress/data/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:mzikplayer/data/values/colors.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget{
  static const routeName = "/about";
  const AboutPage({Key? key, this.title}) : super(key: key);
  final String? title;

  static Route route({isSystemSet = false}) {


    if(isSystemSet) SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          //systemNavigationBarColor: Colors.transparent,
        )
    );
    return MaterialPageRoute<void>(builder: (_) => AboutPage());
  }


  @override
  State<StatefulWidget> createState() {
    //throw UnimplementedError();
    return _AboutState();
  }
}

class _AboutState extends State<AboutPage>{
  var text;
  var timeUpdate = new DateTime.now();
  String appVersion = "0.2.0";

  @override
  initState() {
    super.initState();
    initPlatformPackageInfo();
    //PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //appVersion = packageInfo.version;

  }


  initPlatformPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
    //String appName = packageInfo.appName;
    //String packageName = packageInfo.packageName;
    //appVersion = packageInfo.version;
    //String buildNumber = packageInfo.buildNumber;
  }

  Future<bool> _willPop(){
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).primaryColor,
        )
    );
    return Future.value(true);
  }


  @override
  Widget build(BuildContext context) {
    text =  BlocProvider.of<LanguageBloc>(context).state.strings;

    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        //backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          leading: Ink(
            decoration: const BoxDecoration(),
            child: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(Icons.close, size: 28,),
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          //textTheme: Theme.of(context).textTheme,
          title: Text(text['about'],
            style: TextStyle(
              color: Theme.of(context).primaryColorDark
            ),
          ),
        ),
        body: Container(
            child: contentAbout()
        ),

      ),
    );
  }
  Widget contentAbout(){
    var primaryTextStyle20 = Theme.of(context)
        .textTheme.bodyText2!
        .copyWith(fontSize: 17, /*fontWeight: FontWeight.bold*/);
    var textSettingsStyle = TextStyle(color: Colors.blue[600]);

    return ListView(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0,),
      children: <Widget>[
        const SizedBox(height: 82,),
        Card(
          //color: background2,
          child: Column(
            children: <Widget>[
              Container(child: Column(children: [
                Container(
                  height: 150,
                  child: Image.asset("assets/img/exploress_icon.png"),
                ),
                Text(
                  "Exploress",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24),
                ),
                const Text("@lordyhas7",),

              ],),),
              /*ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage("assets/img/exploress_icon.png"),
                ),
                title: Text(
                  "Exploress",
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 24),),
                subtitle: Text("@lordyhas7",style:  TextStyle(/*color: textWhiteColor54*/),),

              ),*/
              ListTile(
                leading: const Icon(Icons.info),
                title: Text("Version", style: primaryTextStyle20,),
                subtitle: Text("$appVersion (non-stable)",),

              ),
              ListTile(
                leading: const Icon(Icons.update),
                title: Text(text['about_update'], style: primaryTextStyle20,),
                subtitle: Text("${timeUpdate.subtract(Duration(days: 35, hours: 1))}",
                ),

              ),
              ListTile(
                leading: const Icon(Icons.sync),
                title: Text("Changelog",style: primaryTextStyle20,),
              ),

              ListTile(
                leading: const Icon(Icons.turned_in_not),
                title: Text(text['about_licence'],style: primaryTextStyle20,),
              ),
            ],
          ),
        ),

        Card(
          //color: background2,
          child: Column(
            children: <Widget>[

              ListTile(
                  title: Text(text['about_author'],style: textSettingsStyle,),
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.user),
                title: Text("Hassan K.",style: primaryTextStyle20,),
                subtitle: const Text("dev.haspro@gmail.com",),

              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.googlePlay),
                title: Text("Play Store",style: primaryTextStyle20,),
              ),

              ListTile(
                leading: const Icon(Icons.group_outlined),
                title: Text("Our team",style: primaryTextStyle20,),
              ),
            ],
          ),
        ),
        Card(
          //color: background2,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(text['about_company'],style: textSettingsStyle,),
              ),
              ListTile(
                leading: const Icon(Icons.business),
                title: Text("KDynamic Inc.",style: primaryTextStyle20,),
                subtitle: const Text("Mobile App Developers ",),
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(text['about_add'],style: primaryTextStyle20,),
                subtitle: const Text("None ",),
              ),

            ],
          ),
        ),
      ],
    );
  }
}