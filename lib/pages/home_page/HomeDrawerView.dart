part of '../home_page.dart';

// ignore: must_be_immutable
class DrawerView extends Drawer {
  final List<Widget> buttonSubMenuList;
  var text;


  DrawerView({
    required this.buttonSubMenuList,
    Key? key,
    double elevation = 16.0,
    Widget? child,
    String? semanticLabel,

  }) : super(key: key, elevation: elevation, semanticLabel: semanticLabel);



  @override
  Widget build(BuildContext context) {
    text = BlocProvider.of<LanguageBloc>(context).state.getStrings();
    String? userName = BlocProvider.of<AuthenticationBloc>(context).state.user.name;
    var user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    return Drawer(
      //semanticLabel: "Open Menu",
      child: Container(
        ///color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.only(top: 52.0),
        child: Column(
          children: [
            Container(
              height: 130,
              //color: Colors.grey,
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 80,
                      /*decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/img/exploress_icon.png"),
                        )
                      ),*/
                      child: Image.asset(
                        "assets/img/exploress_icon.png",
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: "Explore",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 34,
                        ), //Theme.of(context).textTheme.headline5,
                        children: [
                          TextSpan(
                            text: "ss",
                            style: TextStyle(
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Text(text['label']),
                  ),
                  Expanded(
                    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case AuthenticationStatus.authenticated:
                            return Container(
                                margin: const EdgeInsets.all(8.0),
                                child: Chip(
                                  avatar: CircleAvatar(
                                    backgroundColor: context
                                        .read<StyleAppTheme>()
                                        .originalPrimaryOrange,
                                    child: Text('${userName!.substring(0, 1)}',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight)),
                                  ),
                                  label: Text(
                                    '$userName',
                                  ),
                                ));
                          default:
                            return Container();
                        }
                      },
                    ),
                  ),


                  /**(context.bloc<AuthenticationBloc>().state.status == AuthenticationStatus.authenticated)
                      ? Container(
                          margin: EdgeInsets.all(8.0),
                          child: Chip(
                            avatar: CircleAvatar(
                              backgroundColor: Colors.grey.shade800,
                              child: Text('${userName.substring(0,1)}'),
                            ),
                            label: Text('$userName'),
                          ),
                    //Text("Connected : $userName " /*"Find shop near to you"*/),
                        )
                      : Container(),*/
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                      width: 100,
                      child: ListTile(
                        title: Text(
                          text['home'],
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                        ),
                        onTap: () {
                          Navigator.pop(context);

                        },
                      )),

                  Container(
                      width: 100,
                      child: ListTile(
                        title: Text(
                          text['drawer_shop'],
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                        ),
                        onTap: () {
                          Navigator.push(context, ShopPage.route());

                        },
                      )),
                  /*Container(
                      child: ButtonSubMenu(
                        title: "Shop",
                        subListType: SubListType.shop,
                      )),*/
                  Container(
                      child: ButtonSubMenu(
                        title: text['drawer_prod'],
                        subListType: SubListType.product,
                      )),
                  Container(
                      child: ButtonSubMenu(
                        title: text['drawer_restaurant'],
                        subListType: SubListType.restaurant,
                      )),

                  Container(
                      width: 100,
                      child: ListTile(
                        title: Text(
                          text['drawer_about'],
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                        ),
                        onTap: () {
                        },
                      )),
                  const Divider(),
                  //Container( child: ListTile(title: Text("Other :"),)),
                  Container(
                      width: 100,
                      child: ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        title: Text(
                          BlocProvider.of<LanguageBloc>(context)
                              .state
                              .strings['set_name']!,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                        ),
                        onTap: () {
                          Navigator.push(context, SettingPage.route());
                          /*Navigator.push(context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => BlocProvider(
                                  create: (_) => LanguageBloc(),
                                  child: SettingPage()),
                            ),
                          );*/
                        },
                      )),
                  Container(
                      width: 100,
                      child: ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        title: Text(
                          text['drawer_about'],
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                        ),
                        onTap: () {
                          Navigator.push(
                              context, AboutPage.route(isSystemSet: true));
                        },
                      ),
                  ),
                  Container(
                      width: 100,
                      child: ListTile(
                        leading: Icon(
                          Icons.more_horiz,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        title: Text(
                          "More",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                        ),
                        onTap: () {
                          Navigator.push(context, SplashPage.route());

                        },
                      )),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).primaryColorDark.withOpacity(0.7),
              height: 1.0,
            ),
            Container(
              //width:100,
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  switch (state.status) {
                    case AuthenticationStatus.authenticated:
                      return Container(
                        //width: 100,
                          child: ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: Theme.of(context).primaryColorLight,
                            ),
                            title: Text(
                              "Deconnexion".toUpperCase(),
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                            onTap: () {
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(AuthenticationLogoutRequested());
                            },
                          ));
                    case AuthenticationStatus.unknown:
                      return Container(
                        //width: 100,
                          child: ListTile(
                            leading: Icon(
                              Icons.login,
                              color: Theme.of(context).primaryColorLight,
                            ),
                            title: Text(
                              "Connexion".toUpperCase(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                            ),
                            onTap: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Profile())
                              Navigator.push(context, LoginPage.route());

                              ///context.bloc<AuthenticationBloc>().add(AuthenticationLogoutRequested());
                            },
                          ));
                    default:
                      return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );

  }


}
