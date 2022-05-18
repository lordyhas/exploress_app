part of '../home_page.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver  {



  String? appBarBackgroundImage;
  var text;
  final FirebaseManager firebaseManager = FirebaseManager();
  final DatabaseManager objectBoxManager = DatabaseManager.empty();

  //AppData? appData;

  //String? themeName;

  final int slidesLength = 4;


  //late AnimationController animationController;
  final ScrollController _scrollController = ScrollController();
  late final TabController? _slideTabController;

  @override
  void initState() {
    print('###### initState(HOME-SCREEN) #######');
    super.initState();
    _slideTabController = TabController(vsync: this, length: 4);


  }

  _setSystemUIForProductDesign() => SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        //statusBarColor: Colors.transparent,
        //statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).primaryColorLight,
      )
  );
  void _slideAnimationStart() {
    int i = 0;
    Timer.periodic(Duration(seconds: 5), (timer) {
      //print("Slide Move img to : $i");
      if (i == slidesLength) i = 0;
      if (!_slideTabController!.indexIsChanging) {

      }
      _slideTabController?.animateTo(i);
      i++;

      //print(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    void _setSystemUIOverlayStyle() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        //statusBarIconBrightness: Theme.of(context).brightness,
        systemNavigationBarColor: Theme.of(context).primaryColor,
      ));
    }

    _setSystemUIOverlayStyle();


    //SystemChrome.restoreSystemUIOverlays();
    //addToDatabase();
    /* print(
        'autoGenerateUniqueId :'
        + ProductData().autoGenerateUniqueId("shop") + '=== ===');*/

    text = BlocProvider.of<LanguageBloc>(context).state.getStrings();
    double maxSizeTitle = 750.0;
    //print("Screen Height : ${MediaQuery.of(context).size.height} ");
    //print("Screen Width  : ${MediaQuery.of(context).size.width} ");
    var size = MediaQuery.of(context).size;

    Future<bool> _willPopDialog() async {
      bool value = false;
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        headerAnimationLoop: false,
        animType: AnimType.TOPSLIDE,
        title: 'Warning',
        desc: 'Are you sure you want to delete the item',
        //btnCancelColor: Theme.of(context).,
        btnCancelOnPress: () {
          setState(() {
            value = false;
          });
        },
        //() => Navigator.of(context).pop(false),
        btnOkColor: Theme.of(context).accentColor,
        btnOkOnPress: () {
          setState(() {
            value = true;
          });
        }, //() => Navigator.of(context).pop(true)
      ).show();
      return value;
      /*return (await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Are you sure",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          content: Text("Do you want to exit Exploress ?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Yes"),
            ),
          ],
        ))) ?? false;*/
    }

    var img = [
      Container(
        //padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                child: Image.asset("assets/img/pub_sofa.jpeg",
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  width: size.width,
                )
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: ListTile(
                leading: Container(
                  //width: 70,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/img/exploress_icon2.png",
                      color: Colors.white,
                    ),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    text: "Explore",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: 42, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: "ss",
                        style: TextStyle(
                            color: Colors.deepPurpleAccent),
                      )
                    ],
                  ),
                ),
                subtitle: Text(
                  BlocProvider.of<LanguageBloc>(context)
                      .state
                      .strings['label']!,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        //padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              //margin: EdgeInsets.all(32.0),
              child: Image.asset(
                'assets/img/background/banner_bg.png',
                fit: BoxFit.cover,
                width: size.width,
                height: 199,
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              height: 150,
              //color: Colors.deepOrange,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/banner_img.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: ListTile(
                leading: Container(
                  //width: 70,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/img/exploress_icon2.png",
                      color: Colors.white,
                    ),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    text: "Explore",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: 42, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: "ss",
                        style: TextStyle(
                            color: Colors.deepPurpleAccent),
                      )
                    ],
                  ),
                ),
                subtitle: Text(
                  BlocProvider.of<LanguageBloc>(context)
                      .state
                      .strings['label']!,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        //padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              //margin: EdgeInsets.all(32.0),
              child: Image.asset(
                'assets/img/background/banner_bg.png',
                fit: BoxFit.cover,
                width: size.width,
                height: 199,
              ),
            ),
            Container(
              margin: EdgeInsets.all(32.0),
              child: Image.asset('assets/img/feature_4.png'),
            ),
            Align(
              alignment: Alignment.bottomCenter ,
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text('Sofa Promotion de 50%, chez Prostyle 243')
              ),
            ),
          ],
        ),
      ),

      Container(
        //padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                child: Image.asset("assets/img/pub_headset.jpeg",
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  width: size.width,
                )
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: ListTile(
                leading: Container(
                  //width: 70,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/img/exploress_icon2.png",
                      color: Colors.white,
                    ),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    text: "Explore",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: 42, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: "ss",
                        style: TextStyle(
                            color: Colors.deepPurpleAccent),
                      )
                    ],
                  ),
                ),
                subtitle: Text(
                  BlocProvider.of<LanguageBloc>(context)
                      .state
                      .strings['label']!,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),

      /*Container(
        //padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              //margin: EdgeInsets.all(32.0),
              child: Image.asset(
                'assets/img/background/banner_bg.png',
                fit: BoxFit.cover,
                width: size.width,
                height: 199,
              ),
            ),
            Container(
              margin: EdgeInsets.all(32.0),
              child: Image.asset('assets/img/feature_4.png'),
            ),
            Align(
              alignment: Alignment.bottomCenter ,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text('Sofa Promotion 50%, Porstyle 243')
              ),
            ),
          ],
        ),
      ),*/
    ]..length = slidesLength;

    List<Widget> buttonSubMenuList = [
      Container(
          width: 100,
          child: ListTile(
            title: Text(
              text['home'],
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            ),
            onTap: () {
              setState(() {
                //f(Scaffold.of(context).hasDrawer) Navigator.pop(context);
              });
            },
          )),
      Container(
          child: ButtonSubMenu(
            isWeb: kIsWeb,
            title: text['shop'],
            subListType: SubListType.shop,
          )),
      Container(
          child: ButtonSubMenu(
            isWeb: kIsWeb,
            title: text['product'],
            subListType: SubListType.product,
          )),
    ];

    return WillPopScope(
      onWillPop: _willPopDialog,
      child: DefaultTabController(
        length: img.length,
        child: Scaffold(
          //backgroundColor: scaffoldBackgroundColor,
          appBar: AppBar(
            elevation: 0.0,
            leading: (MediaQuery.of(context).size.width < maxSizeTitle)
                ? Builder(
              builder: (BuildContext context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  _setSystemUIOverlayStyle();
                  Scaffold.of(context).openDrawer();
                },
                tooltip: text[
                'tooltip_open_menu'],
                //MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            )
                : null,
            //backgroundColor: Colors.transparent,
            title: RichText(
              text: TextSpan(
                text: "Explore",
                style: Theme.of(context).textTheme.headline6,
                children: [
                  TextSpan(
                    text: "ss",
                    style:
                    TextStyle(color: Theme.of(context).primaryColorLight),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              (MediaQuery.of(context).size.width > maxSizeTitle)
                  ? Row(
                children: buttonSubMenuList,
              )
                  : Container(),
              Row(
                children: [
                  IconButton(
                      tooltip: text['tooltip_search'],
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.push(
                          context,
                          ProfilePage.routeSearch(),
                        );

                        /*Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) => SignInPage(
                                signInPageSelected: SignInPageSelected.login,
                              ),),
                          );*/
                        /*Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) => ProductPage(),),
                            );*/
                        //Navigator.of(context).pushReplacementNamed('/profile');
                      }),
                  IconButton(
                      tooltip: text['tooltip_profile'],
                      icon: Icon(FontAwesomeIcons.userCircle),
                      onPressed: () {
                        var check = BlocProvider.of<AuthenticationBloc>(context)
                            .state
                            .status;

                        switch (check) {
                          case AuthenticationStatus.authenticated:
                            _setSystemUIOverlayStyle();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    new ProfilePage()));
                            break;
                          case AuthenticationStatus.unauthenticated:
                          case AuthenticationStatus.unknown:
                          //Navigator.pushReplacement(context, LoginPage.route());
                            Navigator.pushAndRemoveUntil(
                                context, LoginPage.route(), (route) => true);
                            break;
                        }
                      }),
                  IconButton(
                      tooltip: text['tooltip_reserve'],
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.push(
                          context,
                          ProfilePage.routeToShopping(),
                        );
                      }),
                ],
              ),
            ], //Text("Exploress"),
          ),
          drawer: ContainerBooleanBuilder(
            check: (MediaQuery.of(context).size.width < maxSizeTitle),
            ifTrue: DrawerView(buttonSubMenuList: buttonSubMenuList),
            ifFalse: null,
          ),
          body: NestedScrollView(
              controller: _scrollController,

              ///floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Container(
                          color: context.read<StyleAppTheme>().originalPrimaryOrange,
                          //HexColor('#ff7f00'), //Colors.deepOrange.shade400,
                          child: Builder(
                            builder: (BuildContext context) => Container(
                              height: 200,
                              //padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  TabBarView(
                                    controller: _slideTabController,
                                    children: img,
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      TabPageSelector(
                                        controller: _slideTabController,
                                        selectedColor: Colors.white,
                                      ),
                                      Spacer(),
                                    ],
                                  ),

                                  /*ElevatedButton(
                                    onPressed: () {
                                      final TabController controller =
                                      DefaultTabController.of(context)!;
                                      if (!controller.indexIsChanging) {
                                        controller.animateTo(img.length - 1);
                                      }
                                    },
                                    child: const Text('SKIP'),
                                  )*/
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: 1,
                      addSemanticIndexes: false,
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: ContestTabHeader(
                      child: BlocBuilder<StyleAppTheme, ThemeData>(
                        bloc: BlocProvider.of<StyleAppTheme>(context),
                        builder: (context, theme) {
                          _setSystemUIOverlayStyle();
                          return Container(
                            color: theme.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 8, bottom: 4),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '5030 product listed',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "I'm lucky",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w100,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.push<dynamic>(
                                                  context,
                                                  MaterialPageRoute<dynamic>(
                                                      builder: (BuildContext context) => FiltersScreen(),
                                                      fullscreenDialog: true),
                                                );
                                                print('pressed ======= ======');
                                                //_addToDatabase();
                                              },
                                              child: Icon(Icons.sort,
                                                  color: Theme.of(context)
                                                      .primaryColorLight),
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        //child:
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    (kIsWeb)
                        ? Container(
                      height: 200,
                      color: Theme.of(context).primaryColor,
                    )
                        : Container(),
                    SizedBox(
                      height: 16,
                    ),

                    FutureBuilder<List<ProductData>>(
                        future: firebaseManager.getTendencyProduct(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData){
                            var productsSnapshot = snapshot.data!;
                            return Column(
                              children: [
                                ListTile(
                                  title: Text("Produit Tendance ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(fontSize: 20)),
                                  trailing: Container(
                                    width: 110,
                                    child: Row(
                                      //mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // FlatButton(onPressed: (){}, child:  Text("Next")),
                                        //Text(" | "),
                                        //FlatButton(onPressed: (){}, child:  Text("Previous")),
                                        InkWell(
                                          child: Text("Previous"),
                                          onTap: () {
                                            print('Previous');
                                          },
                                        ),
                                        Text(" | "),
                                        InkWell(
                                          child: Text("Next"),
                                          onTap: () {
                                            print('next');
                                          },
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                                ParallaxViewPager(
                                  //defaultIndex: 0,
                                    children: productsSnapshot.map(
                                            (product) =>  DescriptionContent(
                                          onPressed: () {
                                            Navigator.push(context,
                                              MaterialPageRoute<void>(
                                                builder: (_) =>
                                                    QuickSingleProductScreen(
                                                      onLikeClick: () {  },
                                                      product: product,
                                                    ),
                                              ),
                                            );
                                          },
                                          onReservedClick: () {
                                            //int index = productsSnapshot.indexOf(e);
                                            BlocProvider.of<ShoppingCartBloc>(context)
                                                .append(
                                              reserved: ReservedProduct.reserved(
                                                product,
                                                userCode: BlocProvider
                                                    .of<AuthenticationBloc>(context)
                                                    .state.user.email,

                                              ),
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              new SnackBar(
                                                  backgroundColor: Theme.of(context).primaryColorDark,
                                                  content: new Text(' Produit Reservé ')
                                              ),
                                            );
                                            firebaseManager.addReservedProduct(
                                                reserved: ReservedProduct.reserved(
                                                  product,
                                                  userCode: BlocProvider
                                                      .of<AuthenticationBloc>(context)
                                                      .state.user.email,
                                                ));
                                            Log.out(
                                                "ProductReserved",
                                                "onReservedClick(add : ${
                                                    product.toString()})");

                                          },
                                          onFavoriteClick: (){},
                                          productData:product,
                                        )
                                    ).toList()
                                  /*List.generate(7, (i) =>
                                        DescriptionContent(
                                          onPressed: () {  },
                                          onReservedClick: () {  },
                                          onFavoriteClick: (){},
                                          imagePath: 'assets/img/p2/i${i+1}.jpg',
                                          //productName: "Product ${i+1}",
                                          //price: 50 + Random().nextInt(50),
                                          productData: ProductData.fromMap(data),
                                        )
                                    )*/
                                ),
                              ],
                            );
                          }


                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              child: Column(
                                children: [

                                  ListTile(
                                    title: Text("Produit Tendance",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(fontSize: 20)),
                                    trailing: Text("Previous | Next"),
                                  ),
                                  ChargingWidget(isTendency: true,),
                                ],
                              ),
                            ),

                          );
                        }
                    ),

                    FutureBuilder<List<ProductData>>(
                        future: firebaseManager.getRecommendedProduct(),
                        builder: (context, snapshot) {
                          bool like = false;
                          if(snapshot.hasData) {
                            if(snapshot.data!.isNotEmpty)
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text("Recommander",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(fontSize: 20)),
                                    trailing: Text("Previous | Next"),
                                  ),
                                  Card(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 4.0),
                                    elevation: 30,
                                    color: Colors.transparent,
                                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(17),
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: snapshot.data!.map((product) =>
                                              InkWell(
                                                onTap: (){
                                                  _setSystemUIForProductDesign();
                                                  Navigator.push(context,
                                                      DetailProductPage.route(
                                                        product,
                                                      ));
                                                },
                                                child: Container(
                                                  height: 200,
                                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        child: Hero(
                                                          tag: product.productCode,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(20),
                                                            child: Image.memory(product.image!.bytes),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(top: 16.0, left: 16.0),
                                                        child: RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  color: Colors.black54
                                                              ),
                                                              children: [
                                                                TextSpan(text: "${product.productName}\n",
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                                TextSpan(text: "à ${product.price} \$\n"),
                                                                //TextSpan(text: "${product.stockNumber} en stock\n"),
                                                                //TextSpan(text: "\n ${e.}"),

                                                              ]
                                                          ),

                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment.bottomLeft,
                                                        child: IconButton(
                                                            onPressed: (){
                                                              like = !like;
                                                            },
                                                            icon: !like
                                                                ? Icon(Icons.favorite_border,
                                                              color: Theme.of(context).accentColor,
                                                            )
                                                                : Icon(Icons.favorite,
                                                              color: Theme.of(context).primaryColor,
                                                            )
                                                        ),
                                                      )
                                                    ],
                                                  ),

                                                  //color: Colors.grey,
                                                  //color: Colors.transparent,

                                                  //width: 200, height: 200,
                                                ),
                                              ),
                                          ).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                          }

                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              child: Column(
                                children: [

                                  ListTile(
                                    title: Text("Recommander",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(fontSize: 20)),
                                    trailing: Text("Previous | Next"),
                                  ),
                                  ChargingWidget(),
                                ],
                              ),
                            ),

                          );
                        }
                    ),

                    FutureBuilder<List<ProductData>>(
                        future: firebaseManager.getFurnitureProduct(),
                        builder: (context, snapshot) {
                          bool like = false;
                          if(snapshot.hasData) {
                            if(snapshot.data!.isNotEmpty)
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text("Les Meubles",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(fontSize: 20)),
                                    trailing: Text("Previous | Next"),
                                  ),
                                  Card(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 4.0),
                                    elevation: 30,
                                    color: Colors.transparent,
                                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(17),
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: snapshot.data!.map((product) =>
                                              Hero(
                                                tag: product.productCode,
                                                child: InkWell(
                                                  onTap: (){
                                                    _setSystemUIForProductDesign();
                                                    Navigator.push(context, DetailProductPage.route(
                                                      product,
                                                    ));
                                                  },
                                                  child: Container(
                                                    height: 200,
                                                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(20),
                                                            child: Image.memory(product.image!.bytes),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(top: 16.0, left: 16.0),
                                                          child: RichText(
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    color: Colors.black54
                                                                ),
                                                                children: [
                                                                  TextSpan(text: "${product.productName}\n",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                  TextSpan(text: "à ${product.price} \$\n"),
                                                                  //TextSpan(text: "${product.stockNumber} en stock\n"),
                                                                  //TextSpan(text: "\n ${e.}"),

                                                                ]
                                                            ),

                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment.bottomLeft,
                                                          child: IconButton(
                                                              onPressed: (){
                                                                like = !like;
                                                              },
                                                              icon: !like
                                                                  ? Icon(Icons.favorite_border,
                                                                color: Theme.of(context).accentColor,
                                                              )
                                                                  : Icon(Icons.favorite,
                                                                color: Theme.of(context).primaryColor,
                                                              )
                                                          ),
                                                        )
                                                      ],
                                                    ),

                                                    //color: Colors.grey,
                                                    //color: Colors.transparent,

                                                    //width: 200, height: 200,
                                                  ),
                                                ),
                                              ),
                                          ).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                          }

                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              child: Column(
                                children: [

                                  ListTile(
                                    title: Text("Les Meubles",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(fontSize: 20)),
                                    trailing: Text("Previous | Next"),
                                  ),
                                  ChargingWidget(),
                                ],
                              ),
                            ),

                          );
                        }
                    ),


                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        child: Column(
                          children: [

                            ListTile(
                              title: Text("Les Smartphones ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 20)),
                              trailing: Text("Previous | Next"),
                            ),
                            ChargingWidget(),
                          ],
                        ),
                      ),

                    ),
                    SizedBox(height: 16.0,),
                    Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),

                    SizedBox(height: 16.0,),
                  ],
                ),
              )),
          /**/
        ),
      ),
    );
  }
}


class ChargingWidget extends StatelessWidget {
  final bool isTendency;
  ChargingWidget({this.isTendency = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(isTendency) SizedBox(width: 90,)
            else SizedBox(),
            for (int i = 1; i < 6; i++)
              Container(
                margin:EdgeInsets.symmetric(horizontal:8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: isTendency ? 210 :200,
                    width: isTendency ? 210 :200,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


