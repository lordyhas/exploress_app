import 'package:exploress/data/app_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:utils_component/utils_component.dart';



const String _textMark = ''' 
##Phone :
Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
##TV :
Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo.
#Etape
- 1. Primo
- 2. Secundo
- 3. Tertio
                              
''';

class DetailProductPage extends StatefulWidget {
  final imagePath;
  final String? heroTag;
  final productCode;
  final productName;
  final double? price;
  final int? stock;
  final bool? canReserve;
  final ProductData productData;

  DetailProductPage(
      {this.imagePath,
      this.heroTag,
      this.productCode,
      this.productName,
      this.price,
      this.stock,
      this.canReserve,
      required this.productData});

  factory DetailProductPage.fromProduct({
    required ProductData product,
  }) => DetailProductPage(
        heroTag: product.productCode,
        productData: product,
      );

  @override
  _DetailProductPageState createState() => _DetailProductPageState();

  static MaterialPageRoute route(ProductData data) => MaterialPageRoute(
      builder: (ctx) => DetailProductPage.fromProduct(product: data,)
  );
}

class _DetailProductPageState extends State<DetailProductPage> {
  int reservation = 1;
  int currentPage = 0;
  PageController? _pageController;
  ScrollController _scrollController = new ScrollController(
    //initialScrollOffset: 99,
    keepScrollOffset: true,
  );

  final FirebaseManager firebaseManager = new FirebaseManager();

  bool isOkTopBtn = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _scrollController.addListener(() {
      print(_scrollController);
      var _topBtnStatus = false;
      if (_scrollController.offset > 100) _topBtnStatus = true;
      setState(() {
        this.isOkTopBtn = _topBtnStatus;
      });
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var product = widget.productData;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        //bottomSheet: DraggableScrollableSheetWidget(),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 200.0, bottom: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
            Column(
              children: [
                AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Text("Details du produit"),
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),

                ///-----------///
                SizedBox(
                  height: 16.0,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 52.0, right: 52.0),
                        child: Card(
                          borderOnForeground: true,
                          color: Colors.transparent,
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            child: Hero(
                                tag: product.productCode,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                    child: Image.memory(product.image!.bytes))
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          product.productName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 24),
                        ),
                      ),
                      Container(
                        height: 75,
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 150,
                              child: ListTile(
                                title: Text(
                                  "\$${product.price} ",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                subtitle: Text(
                                  "En Stock : ${product.stockNumber}",
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 2.0,
                              color: Colors.grey,
                            ),
                            Container(
                              height: 60,
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.add_shopping_cart,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  Text(
                                    " : ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontSize: 20),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(17)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              setState(() {
                                                if (reservation > 0)
                                                  reservation--;
                                              });
                                            }),
                                        Text(
                                          "$reservation",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          alignment: Alignment.topCenter,
                                          //margin: EdgeInsets.only(top:3.0, bottom: 3.0),

                                          child: IconButton(
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              icon: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                9.5))),
                                                child: Icon(Icons.add),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if (reservation <
                                                      product.stockNumber - 1)
                                                    reservation++;
                                                });
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                          ),
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              children: [
                                Container(
                                  height: 115,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      for (int i = 0; i < 4; i++)
                                        Container(
                                          //width: 100,
                                          //height: 0,
                                          margin: EdgeInsets.all(8.0),
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                          ),
                                          child: Image.memory(product.image!.bytes),
                                        ),
                                    ],
                                  ),
                                ),

                                /// todo  : Delete this if platform is android
                                (kIsWeb)
                                    ? Container(
                                        height: 400,
                                        child: PageView(
                                          controller: _pageController,
                                          children: [
                                            _buildSheetChild(
                                              title: "Description",
                                              body: Text(
                                                "Lorem ipsum dolor sit amet, consectetur adipisicing elit, "
                                                "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                                                "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris "
                                                    "nisi ut aliquip ex ea commodo \n"
                                                "Lorem ipsum dolor sit amet, consectetur adipisicing elit, "
                                                "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                                                "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris "
                                                    "nisi ut aliquip ex ea commodo. \n"
                                                "First replenish living. Creepeth image image. Creeping can't, won't "
                                                    "called. Two fruitful let days "
                                                "signs sea together all land fly subdue.",
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(8.0)
                                                  .copyWith(
                                                      left: 8.0, right: 8.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Text("Description"),
                                                  ),
                                                  Divider(
                                                    indent: 32.0,
                                                    endIndent: 32.0,
                                                  ),
                                                  Text(
                                                    "Lorem ipsum dolor sit amet, consectetur adipisicing elit, "
                                                    "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                                                    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo \n"
                                                    "Lorem ipsum dolor sit amet, consectetur adipisicing elit, "
                                                    "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                                                    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo. \n"
                                                    "First replenish living. Creepeth image image. Creeping can't, won't called. Two fruitful let days "
                                                    "signs sea together all land fly subdue.",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colors.red,
                                              child: Center(
                                                child: RaisedButton(
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    if (_pageController!
                                                        .hasClients) {
                                                      _pageController!
                                                          .animateToPage(
                                                        2,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    400),
                                                        curve: Curves.easeInOut,
                                                      );
                                                    }
                                                  },
                                                  child: Text('Next'),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              color: Colors.blue,
                                              child: Center(
                                                child: RaisedButton(
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    if (_pageController!
                                                        .hasClients) {
                                                      _pageController!
                                                          .animateToPage(
                                                        0,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    400),
                                                        curve: Curves.easeInOut,
                                                      );
                                                    }
                                                  },
                                                  child: Text('Previous'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
              ],
            ),
            /*Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(8.0).copyWith(bottom: 8.0),
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  border: Border.all(
                    width: 3.0,
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: (){
                          if (_pageController.hasClients) {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        }
                    ),
                    Container(child: Text("\$25.00"),),
                    Row(
                      children: [
                        (isOkTopBtn)?
                        IconButton(
                          //color: Theme.of(context).primaryColorLight,
                            icon: Container(
                              child: Icon(Icons.arrow_circle_up),
                            ),
                            onPressed: (){
                              _scrollController.jumpTo(-50);
                            }
                        ): Container(),
                        IconButton(
                          //color: Theme.of(context).primaryColorLight,
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: (){
                              if (_pageController.hasClients) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            }
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),*/
            BooleanBuilder(
                check: !kIsWeb,
                ifTrue: _DraggableBottomSheet(
                  childrenTitle: [
                    Text("Description"),
                    Text("Specification"),
                    Text("Comment"),
                    Text("Review")
                  ],
                  childrenBody: [
                    /*Container(
                        child: Markdown(
                          data:

                        ),
                      ),*/
                    Container(
                      child: Text( product.about ?? "No information about product"),
                    ),

                    Container(
                      child: Center(
                        child: Text(
                          "\nNo Specification for this product",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text("\nNo comment",style: TextStyle(fontSize: 20),),
                      ),
                    ),
                    Container(
                      height: 100,
                      //color: Colors.red,
                      child: Placeholder(),
                    ),
                  ],
                ),
                ifFalse: Container()
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildPageViewChild({
    title,
    body,
  }) {
    return Container(
      child: Column(
        children: [],
      ),
    );
  }

  Widget _buildSheetChild({title, body, controller}) {
    return Container(
      padding: EdgeInsets.all(0.0).copyWith(left: 8.0, right: 8.0),
      child: SingleChildScrollView(
        controller: controller,
        child: body,
      ),
    );
  }

  DraggableScrollableSheet _buildScrollableSheet(
      {List<String>? childrenTitle, List<Widget>? childrenBody}) {
    assert(childrenTitle?.length == childrenBody?.length);
    return DraggableScrollableSheet(
      initialChildSize: 0.29,
      maxChildSize: 0.7,
      minChildSize: 0.25,
      builder: (context, scrollController) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.0, left: 4.0, right: 4.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            border: Border.all(
              width: 3.0,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Scaffold(
              primary: true,
              appBar: PreferredSize(
                preferredSize: AppBar().preferredSize,
                child: TabBar(
                  isScrollable: true,
                  labelColor: Theme.of(context).primaryColorLight,
                  indicatorColor: Theme.of(context).primaryColorLight,
                  tabs: childrenTitle!
                      .map((title) => Tab(
                            text: title,
                          ))
                      .toList(),
                ),
              ),
              body: TabBarView(
                children: childrenBody!
                    .map((e) => ListView(
                          padding: EdgeInsets.all(8.0),
                          controller: scrollController,
                          children: [
                            e,
                          ],
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }

/*DraggableScrollableSheet _buildDraggableScrollableSheet({
    childrenTitle,List<Widget> childrenBody
      }){
    return DraggableScrollableSheet(
      initialChildSize: 0.29,
      maxChildSize: 0.7,
      minChildSize: 0.25,
      builder: (context, scrollController) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.0, left: 4.0, right: 4.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            border: Border.all(
              width: 3.0,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(childrenTitle[currentPage], style: TextStyle(fontSize: 20),)
                ),
                /// Divider
                Divider(indent: 32.0, endIndent: 32.0,),
                Expanded(
                  child: Container(
                    //height: 400,
                    child:  PageView(
                      controller: _pageController,
                      onPageChanged: (int page){
                        setState(() {
                          currentPage = page;
                        });
                      },
                      children: [
                        for (var child in childrenBody )
                        _buildSheetChild(
                          controller: scrollController,
                          body: child,
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },

    );
  }*/

}

class _DraggableBottomSheet extends StatelessWidget {
  final List<Text> childrenTitle;
  final List<Widget> childrenBody;

  const _DraggableBottomSheet(
      {Key? key, required this.childrenTitle, required this.childrenBody})
      : assert(childrenTitle.length == childrenBody.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.29,
      maxChildSize: 0.7,
      minChildSize: 0.20,
      builder: (context, scrollController) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.0, left: 4.0, right: 4.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            border: Border.all(
              width: 3.0,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Scaffold(
              primary: true,
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
              appBar: PreferredSize(
                preferredSize: AppBar().preferredSize,
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.deepPurple.shade700,

                  ///Theme.of(context).primaryColorLight,
                  indicatorColor: Theme.of(context).primaryColorLight,
                  tabs: childrenTitle
                      .map((title) => Tab(
                            text: title.data,
                          ))
                      .toList(),
                ),
              ),
              body: TabBarView(
                children: childrenBody
                    .map((e) => ListView(
                          padding: EdgeInsets.all(8.0),
                          controller: scrollController,
                          children: [
                            e,
                          ],
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
/*
class CustomSyntaxHighlighter extends SyntaxHighlighter{
  final h = DartSyntaxHighlighter(SyntaxHighlighterStyle.lightTheme)
  @override
  TextSpan format(String source) {
    return TextSpan();
  }
}
*/