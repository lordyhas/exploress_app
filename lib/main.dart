import 'dart:io' show Directory, Platform;
import 'dart:math';
//import 'dart:io' show Directory;

import 'package:equatable/equatable.dart';
import 'package:exploress/data/app_database.dart';
import 'package:exploress/data/database/model/AppSettingModel.dart';

import 'package:exploress/data/values.dart';

import 'package:exploress/pages/splash_page.dart';
//import 'package:exploress/widget_model/BooleanBuilder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:utils_component/utils_component.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:intl/intl.dart';

import 'pages/home_page.dart';

import 'data/app_bloc_library.dart';

import 'data/values/styles.dart';
import 'pages/login/signup_and_login.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


// todo : Payement, Livraison


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await FacebookSdk.sdkInitialize();
  await Firebase.initializeApp();

  //EquatableConfig.stringify = kReleaseMode;
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = AppBlocObserver();

  //await Hive.initFlutter();
  //await Hive.init();
  //Hive.registerAdapter<Contact>(ContactAdapter());
  HiveBoxManager().onInit<AppSetting>(AppSettingAdapter());
  //Directory appDir = await getApplicationDocumentsDirectory();
  //var path = appDir.path;
  //Hive.init(path);
  //Hive..init(path)..registerAdapter<AppSetting>(AppSettingAdapter());

  if (kDebugMode) {
    print('StartApp: OK');
  }
  /*String os = "=>";
  String osv;
  if(kIsWeb) print('Pexport PATH="$PATH:`pwd`/flutter/bin"latform detected => os: *** is Web OS ***');
  else {
    os = Platform.operatingSystem;
    osv = Platform.operatingSystemVersion;
    if(Platform.isAndroid)
      print('os version: $osv | Platform detected : *** is an Android OS ***');
    else print('*** os: $os | os version => $osv ***');
  }*/

  runApp(MyApp(authenticationRepository: AuthenticationRepository()));
  //print('Running : OK');
}

class MyApp extends StatelessWidget {
  const MyApp({
    required this.authenticationRepository,
    Key? key,

  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  //Store? _store;
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  //DatabaseManager objectboxManager = new DatabaseManager.initStore();

  final FirebaseManager firebaseManager = FirebaseManager();

  //late int themeValue;

  final String defaultSystemLocale = Platform.localeName;
  final List<Locale> systemLocales = WidgetsBinding.instance.window.locales;

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
    //SettingAppData _settingData = objectboxManager.initStoreBoxSetting(_store!);

    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>(
          create: (BuildContext context) =>
              LanguageBloc(LangState.values[2], defaultSystemLocale),
        ),
        BlocProvider<StyleAppTheme>(
          create: (BuildContext context) => StyleAppTheme(),
        ),
        BlocProvider<ShoppingCartBloc>(
          create: (BuildContext context) => ShoppingCartBloc(
            // todo get list from firebase
            ShoppingCartState(List<ReservedProduct>.generate(7,
                    (i) => ReservedProduct(
                        id: i,
                        date: DateTime.now(),
                        productCode: 'Prod(IDx'+DateTime.now()
                            .microsecondsSinceEpoch.toString()+')',
                        shopCode: '',
                        userCode: 'h.kajila@gmail.com',
                        quantity: 1 + Random(i).nextInt(10),
                        isReserved: !(i%3==0),
                    ))
            ),
          ),
        ),
        BlocProvider<MapsBloc>(
          create: (context) => MapsBloc(),
        ),
        BlocProvider<FilterCubit>(
          create: (BuildContext context) =>
              FilterCubit(Filter.values(
                  maxPrice: 600.0,
                  minPrice: 50,
                  maxDistance: 5.0,
                  minDistance: 0.0,
                  categoryList: [])),
        ),
      ],
      child: BlocBuilder<StyleAppTheme, ThemeData>(builder: (_, theme) {
        return BooleanBuilder(
          check: DateTime.now().isAfter(DateTime(2022,12,30,18,00,00)),
          ifTrue: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            title: 'Exploress Soko',
            home: const DefaultPage(),
          ),
          ifFalse: MaterialApp(
            navigatorKey: _navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Exploress Soko', //Explore Shop Service
            supportedLocales: <Locale>[
              const Locale('en'),
              const Locale('fr'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            theme: theme,
            //locale: ,
            //home: HomePage(),

            /*routes:  <String, WidgetBuilder>{
                  '/settings': (BuildContext context) => AboutPage(),
                  '/settings/about': (BuildContext context) => AboutPage(),
                  '/profile/user': (BuildContext context) => ProfilePage(),
                  '/profile/search': (BuildContext context) => ProfilePage(pageSelected: ProfilePageSelected.search,),
                  '/profile/maps': (BuildContext context) => ProfilePage(pageSelected: ProfilePageSelected.search,),
                  '/profile/shopping': (BuildContext context) => ProfilePage(pageSelected: ProfilePageSelected.search,),
                  //'/profile/sign-in': (BuildContext context) => SignInPage(),
                  //'/profile/login': (BuildContext context) => SignInPage(),
                },*/

            builder: (context, child) {
              return BlocListener<AuthenticationBloc, AuthenticationState>(
                child: child,
                listener: (context, state) {
                  switch (state.status) {
                    case AuthenticationStatus.authenticated:
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        statusBarIconBrightness: Theme.of(context).brightness,
                        systemNavigationBarColor: Theme.of(context).primaryColor,
                      ));
                      _navigator.pushAndRemoveUntil<void>(
                        HomePage.route(),
                        (route) => false,
                      );
                      break;
                    case AuthenticationStatus.unauthenticated:
                      _navigator.pushAndRemoveUntil<void>(
                        LoginPage.route(),
                        (route) => false,
                      );
                      break;
                    default:
                      break;
                  }
                },
              );
            },
            onGenerateRoute: (_) => SplashPage.route(),
          ),
        );
      }),
    );
  }
}

class DefaultPage extends StatelessWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            text: "Explore",
            style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
            children: [
              const TextSpan(
                text: "ss",
                style: TextStyle(color: Colors.deepPurpleAccent),
              )
            ],
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.do_not_disturb_alt, size: 200, color: Colors.black87,),
            const Text("This channel is blocked, due to the experimental time expired",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              textAlign: TextAlign.center,
            ),

          ],
        ),
      ),
    );
  }
}



/* MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Explore Shop Service',
        theme: themeDataLight,
        home: HomePage(),
        routes:  <String, WidgetBuilder>{
          //'/about': ProfilePage();
          '/profile/user': (BuildContext context) => ProfilePage(),
          '/profile/search': (BuildContext context) => ProfilePage(indexOfDefaultPage: 2,),
          '/profile/sign-in': (BuildContext context) => SignInPage(),
          '/profile/login': (BuildContext context) => SignInPage(),
        },
      ), */



