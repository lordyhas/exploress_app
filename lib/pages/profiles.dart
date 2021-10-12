import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:animate_icons/animate_icons.dart';
import 'package:exploress/data/app_bloc_library.dart';
import 'package:exploress/data/app_database.dart';
import 'package:exploress/data/values.dart';
import 'package:exploress/data/values/strings.dart';
import 'package:exploress/pages/profiles/maps_test.dart';
import 'package:exploress/pages/settings_and_about/About.dart';
import 'package:exploress/pages/settings_and_about/settings.dart';
import 'package:utils_component/utils_component.dart';
import '../widgets.dart';
import 'login/signup_and_login.dart';
import 'package:exploress/pages/profiles/search/search_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animations/animations.dart';

part 'profiles/profile_maps_screen.dart';

part 'profiles/profile_search_screen.dart';

part 'profiles/profile_shopping_screen.dart';

part 'profiles/profile_user_screen.dart';

part 'profiles/setting_profile/ProfileEditorPage.dart';

part 'profiles/setting_profile/Address.dart';

enum ProfilePageSelected { profileUser, shopping, search, profile }

class ProfilePage extends StatefulWidget {
  //final bool hasAccount;
  final bool fromProduct;

  //final int indexOfDefaultPage;
  final ProfilePageSelected pageSelected;

  ProfilePage({
    this.fromProduct = false,
    this.pageSelected = ProfilePageSelected.profileUser,
  });


  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ProfilePage());
  }

  static Route routeToShopping({BuildContext? context}) {
    /*if(context != null)
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).primaryColor,
      ));*/
    return MaterialPageRoute<void>(
        builder: (_) => ProfilePage(
          pageSelected: ProfilePageSelected.shopping,
        ));
  }

  static Route routeSearch() {
    return MaterialPageRoute<void>(
        builder: (_) => ProfilePage(
          pageSelected: ProfilePageSelected.search,
        ));
  }

  @override
  _ProfilePageState createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedBottomIndex = 0;
  var text;

  @override
  void initState() {
    super.initState();
    /*if(!widget.hasAccount) Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => SignInPage())
    );*/
    _selectedBottomIndex = widget.pageSelected.index;


  }

  int toIndex(ProfilePageSelected pageSelected) {
    return pageSelected.index;
  }

  @override
  Widget build(BuildContext context) {

    text = BlocProvider.of<LanguageBloc>(context).state.strings;

    return WillPopScope(
      onWillPop: () async {

        /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Theme.of(context).brightness,
          systemNavigationBarColor: Theme.of(context).primaryColor,
        ));*/
        return true;
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  //appBar: AppBar(title: Text("Titre"),),
                  body: PageTransitionSwitcher(
                    duration: const Duration(milliseconds: 700),
                    transitionBuilder:
                        (child, primaryAnimation, secondaryAnimation) =>
                          SharedAxisTransition(
                            transitionType: SharedAxisTransitionType.horizontal,
                            animation: primaryAnimation,
                            secondaryAnimation: secondaryAnimation,
                            child: child,
                          ),
                    child: _screens[_selectedBottomIndex]
                  ),
                  //switchWidgetWithBottomIndexValue(),
                  bottomNavigationBar: titledBottomNavigationBar(),
                ),
              );
            case AuthenticationStatus.unauthenticated:
            case AuthenticationStatus.unknown:

              return Scaffold(
                appBar: AppBar(
                  title: Text("You must register or log in",
                    style: TextStyle(
                      //color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,

                    ),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () => Navigator.pushReplacement(
                            context, SettingPage.route()
                        ),
                        icon: Icon(Icons.settings)
                    )
                  ],
                ),
                body: Center(
                  child: Container(
                    height: 400,

                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(),
                          height: 200,
                          child: Image
                                .asset('assets/img/vector/login_vector.png')
                        ),
                        Spacer(flex: 2,),
                        Text("You don't have an account",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,

                          ),
                        ),
                        Spacer(),
                        ButtonBar(
                          //: EdgeInsets.symmetric(horizontal: 8.0),
                          alignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: Theme.of(context).primaryColorLight,
                                shape: StadiumBorder(),
                                side: BorderSide(
                                    width: 3.0,
                                    color: Theme.of(context).primaryColorLight,
                                ),
                              ),
                              onPressed: (){
                                Navigator.pushReplacement(context, LoginPage.route());
                              },
                              child: Text("   Sign in   ",
                                style: TextStyle(fontWeight: FontWeight.bold ),
                              ),
                            ),

                            SizedBox(width: 16.0,),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                shape: StadiumBorder(),
                                side: BorderSide(
                                  width: 3.0,
                                  color: Theme.of(context).primaryColor,
                                )
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text("Remember me later",
                                style: TextStyle(fontWeight: FontWeight.bold ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              );
              break;
          }
        },
      ),
    );
  }

  Widget switchWidgetWithBottomIndexValue() {
    switch (_selectedBottomIndex) {
      case 0:
        return ProfileUserScreen();
      case 1:
        return ShoppingScreen();
      case 2:
        return SearchScreen();
      case 3:
        return MapScreen();
      default:
        return ProfileUserScreen();
    }
  }
  List<Widget> _screens = <Widget>[
    ProfileUserScreen(),
    ShoppingScreen(),
    SearchScreen(),
    MapScreen(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedBottomIndex = index;
      //bottomValue = !bottomValue;
    });
  }

  TitledBottomNavigationBar titledBottomNavigationBar() {
    final itemsBottomBar = <ItemNavigationBar>[
      ItemNavigationBar('My Profile', FontAwesomeIcons.user),
      ItemNavigationBar('Shopping', FontAwesomeIcons.shoppingCart),
      ItemNavigationBar('Search', FontAwesomeIcons.search),
      ItemNavigationBar('Maps', FontAwesomeIcons.mapMarked),
    ];
    return TitledBottomNavigationBar(
      textColor: Colors.white,
      iconColor: Theme.of(context).primaryColorLight,
      elevationShadowColor: Theme.of(context).primaryColorLight,
      currentIndex: _selectedBottomIndex,
      items: itemsBottomBar,
      onTap: _onItemTapped,
    );
  }

  ///List<Widget> listOfWidgetByBottomNavigation = <Widget>[wProfileUser(), wProfileShop(),Container(),];

/*BottomNavigationBar _bottomNavigationBar(){
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).primaryColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          //backgroundColor: Colors.blueGrey,
          icon: Icon(Icons.person_outline),
          title: Text('My Profile'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('Shopping'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Search'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit),
          title: Text('Edit Profile'),
        ),
      ],
      currentIndex: _selectedBottomIndex,
      selectedItemColor: Theme.of(context).primaryColorLight, //Colors.cyan.shade700,
      unselectedItemColor: Colors.white,
      onTap: _onItemTapped,
    );
  }*/

}
/*
class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AppBar(
            title: Text(
              "",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(),
            ),
          )
        ],
      ),
    );
  }
}
*/