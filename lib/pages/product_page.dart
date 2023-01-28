

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploress/data/app_database.dart';
import 'package:exploress/pages/product/single_product_page.dart';
import 'package:exploress/widget_model/ProductCardWidget.dart';
import 'package:exploress/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductPage extends StatefulWidget {
  final String title;
  ProductPage({this.title = "Product Shop"});



  @override
  _ProductPageState createState() => _ProductPageState();
}


class _ProductPageState extends State<ProductPage> {

  final FirebaseManager firebaseManager = new FirebaseManager();
  PersistentBottomSheetController? _persistentController;
  final GlobalKey<ScaffoldState> _globalScaffoldKey = GlobalKey<ScaffoldState>();
  int count = 0;

  bool isBottomSheetOpen = false;

  var orderByList = [
    "Par prix - Ascendant",
    "Par prix - Descendant",
    "Par nom - A á Z",
    "Par nom - Z á A",
  ];

  int radioValue = 0;

  @override
  void initState() {
    super.initState();
    //SystemChrome.restoreSystemUIOverlays();

  }



  @override
  Widget build(BuildContext context) {
    //SystemChrome.restoreSystemUIOverlays();
    /*SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).primaryColorLight,
        )
    );*/



    var choice = <String>[
      "Phone",
      "Laptop",
      "TV",
      "Monitor",
      "Accessoire",
      "USB",
      "Clavier",
    ];

    Future<bool> _willPop(){
      if(isBottomSheetOpen){
        setState(() {
          isBottomSheetOpen = !isBottomSheetOpen;
        });
        Navigator.pop(context);

      }
      else
        SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              systemNavigationBarColor: Theme.of(context).primaryColor,
            )
        );
      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        key: _globalScaffoldKey,
        backgroundColor: Theme.of(context).primaryColorLight,
        body: Column(
          children: [
            /// AppBar
            AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios,),
                onPressed: (){
                  SystemChrome.setSystemUIOverlayStyle(
                      SystemUiOverlayStyle(
                        systemNavigationBarColor: Theme.of(context).primaryColor,
                      )
                  );
                  Navigator.pop(context);
                },
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      //shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.sort_by_alpha,),
                    onPressed: () {
                      double radius = 20;
                      var style = TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme
                              .of(context)
                              .primaryColorDark
                      );
                      _persistentController = _globalScaffoldKey
                          .currentState!
                          .showBottomSheet(
                          //builder:
                            (context) {


                              return ClipRRect(
                                borderRadius: BorderRadius.circular(radius)
                                    .copyWith(bottomLeft: Radius.circular(0.0)),
                                child: Container(
                                  color: Colors.grey, /*Theme
                                      .of(context)
                                      .scaffoldBackgroundColor,*/
                                  height: 250,
                                  child: Column(
                                    children: [0, 1, 2, 3].map((index) =>
                                        ListTile(
                                          leading: Radio<int>(
                                            onChanged: (value) {
                                              _persistentController!.setState!(() {
                                                radioValue = value!;
                                              });
                                              setState(() {
                                                isBottomSheetOpen = !isBottomSheetOpen;
                                              });
                                              Navigator.pop(context);

                                            },
                                            groupValue: radioValue,
                                            value: index,
                                          ),
                                          title: Text(
                                            orderByList[index], style: style,),
                                        ),).toList(),
                                  ),
                            ),
                          );
                            },
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color:Theme.of(context).primaryColorLight
                              ),
                                borderRadius: BorderRadius.circular(radius)
                                    .copyWith(bottomLeft: const Radius.circular(0.0))
                            ),
                          );
                      })
                ),


                const SizedBox(width: 8.0,),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    //shape: BoxShape.circle
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune, ),
                    //todo : OnPressed => Dialog;
                    onPressed: ()  {
                      var checks = List<bool>.generate(10, (i) => (i%3==0));

                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              ChooseCatDialog(
                                title: 'Filtrer par categories',
                                categories: List<CategoryProduct>.generate(choice.length,
                                        (i) => CategoryProduct(
                                          title: choice[i],
                                          value: checks[i],
                                          onCheckClick: (value){
                                            setState(() {
                                              checks[i] = value;
                                            });
                                          },
                                    )
                                ),
                              )
                      );
                    }
                  ),
                ),
                const SizedBox(width: 8.0,),


              ],
            ),

            ///-----------///
            /// BottomAppBar and Text
            Container(
              padding: const EdgeInsets.only(left: 16.0),
              alignment: Alignment.topLeft,
              child: Text(widget.title,
                style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 32),),
            ),
            const SizedBox(height: 16.0,),
            ///-----------///
            /// Body App
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45.0),
                  bottomRight: Radius.circular(45.0),
                ),
                child: Container(
                  //margin: EdgeInsets.only(bottom: 16.0),
                  //padding: EdgeInsets.only(top: 4.0,bottom: 4.0,),
                  decoration: BoxDecoration(
                    /*borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.0),
                      bottomRight: Radius.circular(45.0),
                    ),*/
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Stack(
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          await Future.delayed(const Duration(seconds:3));

                          return  null;
                        },
                        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          future: firebaseManager.collectionProduct.get(),
                          builder: (context, snapshot) {
                            //var map;
                            Map<String, dynamic> data;
                            if (snapshot.hasError) {
                              return Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error_outline,
                                          size: 72,color: Colors.black87,),
                                        const Text('Something went wrong'),
                                      ],
                                    ),
                                  ));
                            }

                            else if(snapshot.data == null)
                              return Center(child: CircularProgressIndicator(),);

                            else if(!snapshot.data!.docs.first.exists)
                              return Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.do_not_disturb_alt,
                                          size: 120,color: Colors.black87,),
                                        SizedBox(height: 8.0,),
                                        Text('No product found (0x001DOC-NPF)'),
                                      ],
                                    ),
                                  )
                              );


                            //if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                            else if(snapshot.connectionState == ConnectionState.done)
                              if(snapshot.data!.docs.isEmpty) return NoData();
                                return ListView(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(
                                    top: 4.0, left: 16.0, right: 16.0,
                                  ),
                                  children: snapshot.data!.docs.map((document) {
                                    count++;
                                    //if(document)
                                    data = document.data();
                                    return ProductCard.fromProductData(
                                      product: ProductData.fromMap(data),
                                      onProductTap: () => Navigator.push(
                                          context,
                                          DetailProductPage.route(
                                            ProductData.fromMap(document.data()),
                                          )
                                      ),
                                    );
                                  }).toList(),
                                );
                            //return Center(child: CircularProgressIndicator());
                          },
                        ),
                        /*FutureBuilder<DocumentSnapshot>(
                          /// put [getUser] here
                          future: firebaseManager.getProductSnapshot(),
                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                            if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }

                            if (snapshot.connectionState == ConnectionState.done) {
                              Map<String, dynamic> data = snapshot.data.data().;
                              if(data.isEmpty) return NoData();
                              data.forEach((key, value) { })
                              var productCardList =  List<ProductCard>.generate(20,
                                      (i) => ProductCard(
                                        imagePath: "assets/img/banner_img.png",
                                        heroTag: "assets/img/banner_img.png$i",
                                        productName: "Product $i",
                                        price: (10+Random(i).nextInt(20)).toDouble(),
                                        stock: 5+Random(i).nextInt(30),
                                        canReserve: !(i%3==0),
                                      )
                              );
                            return ListView(
                                padding: EdgeInsets.only(
                                  top: 4.0, left: 16.0, right: 16.0,
                                ),
                                children: productCardList,
                              );
                            }
                            return CircularProgressIndicator();
                          },
                        ),*/

                        /*ListView(
                          padding: EdgeInsets.only(
                            top: 4.0, left: 16.0, right: 16.0,
                          ),
                          children: [
                            //Padding(padding: EdgeInsets.only()),
                            for(int i=0; i<9; i++)
                            ProductCard(
                              imagePath: "assets/img/banner_img.png",
                              heroTag: "assets/img/banner_img.png$i",
                              productName: "Product $i",
                              price: (10+Random(i).nextInt(20)).toDouble(),
                              stock: 5+Random(i).nextInt(30),
                              canReserve: !(i%3==0),
                            ),

                          ],
                        ),*/
                      ),
                      ///------ Body End
                      /// Bottom App
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 32.0, right: 32.0, bottom: 8.0 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                //padding: EdgeInsets.only(left: 16.0, right: 16.0),
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    width: 2.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                child: IconButton(
                                  tooltip: "Faite une recherche",
                                  icon: Icon(Icons.search,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: (){},
                                ),
                              ),

                              Container(
                                width: 75,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    width: 2.0,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                                child: IconButton(
                                  tooltip: "voir mes reservation",
                                  icon: Icon(Icons.shopping_bag_outlined,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                  onPressed: () {

                                    /*Navigator.push(
                                      context, ProfilePage
                                        .routeToShopping(context: context),
                                    );*/
                                  }
                                ),

                              ),

                              Container(
                                alignment: Alignment.center,
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                  //color: Theme.of(context).primaryColor,
                                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(35),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  border: Border.all(
                                    width: 2.0,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                                child: InkWell(
                                  hoverColor: Theme.of(context).primaryColor,
                                  onTap: (){},
                                  child: Text("Checkout",
                                    style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 22),
                                  ),
                                ),

                              )
                            ],
                          ),
                        ),
                      ),
                      /// ---------
                      /// ---------
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0,),

          ],
        ),
      ),
    );
  }
}
