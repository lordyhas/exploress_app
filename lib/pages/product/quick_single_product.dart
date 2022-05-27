import 'package:exploress/data/app_bloc_library.dart';
import 'package:exploress/data/app_database.dart';
import 'package:exploress/pages/profiles/maps_test.dart';
import 'package:exploress/pages/shop/quick_single_shop.dart';
import 'package:exploress/pages/shop/shop_info_screen.dart';
import 'package:exploress_repository/exploress_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:latlong2/latlong.dart' as dist;
import 'package:utils_component/utils_component.dart';

import '../../data_test.dart';


class QuickSingleProductScreen extends StatefulWidget {
  final ProductData product;
  final Function()? onLikeClick;
  //final Function()? onReservedClick;
  const QuickSingleProductScreen({
    Key? key,
    required this.product,
    required this.onLikeClick,
    //required this.onReservedClick,
  }) : super(key: key);

  @override
  _QuickSingleProductScreenState createState() =>
      _QuickSingleProductScreenState();
  /*static Route route() {

    return MaterialPageRoute<void>(builder: (_) => QuickSingleProductScreen());
  }*/
}

class _QuickSingleProductScreenState extends State<QuickSingleProductScreen> {
  bool likeActive = false;


  @override
  Widget build(BuildContext context) {
    var position = BlocProvider.of<MapsBloc>(context).state.maps;
    var textStyle =
        Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Details'),
        actions: [
          IconButton(
            onPressed: () {
              widget.onLikeClick!();
              setState(() {
                likeActive = !likeActive;
              });
            },
            icon: (likeActive)
                ? Icon(Icons.favorite_border)
                : Icon(Icons.favorite),
          ),
        ],
      ),
      body: ShowProductScreen(widget.product)
    );
  }
}


class ShowProductScreen extends StatelessWidget {
  final ProductData product;
  ShowProductScreen(this.product);

  final FirebaseManager _firebaseManager = FirebaseManager();

  @override
  Widget build(BuildContext context) {
    final shop  = DataTest.shops.first;

    var position = BlocProvider.of<MapsBloc>(context).state.maps;
    var textStyle =
    Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20);
    var size = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            child: Hero(
              //transitionOnUserGestures: true,
              tag: product.productCode,
              child: Container(
                height: size.width * 0.75,
                width: size.width * 0.75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      width: 2.0,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    image: DecorationImage(
                      image: MemoryImage(product.image!.bytes),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 32.0,
          ),
          Container(
            child: Column(
              children: [
                Text(
                  "${product.productName}",
                  style: textStyle,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "\$${product.price}",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                SelectableText(
                  "${DistanceBetween(
                      fromLatLng: position.currentLatLngFromDistance,
                      toLatLng: dist.LatLng(
                          shop.location!.latitude,
                          shop.location!.longitude
                      )).distanceKiloMeter} km from you",
                  style: textStyle.copyWith(
                      fontSize: 16,
                      color: Theme.of(context)
                          .primaryColorDark
                          .withOpacity(0.7)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            //width: ,
            child: Column(
              children: [
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:Theme.of(context).primaryColorLight,
                          //minimumSize: ,
                        ),

                        onPressed: () {
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
                          _firebaseManager.addReservedProduct(
                              reserved: ReservedProduct.reserved(
                                product,
                                userCode: BlocProvider
                                    .of<AuthenticationBloc>(context)
                                    .state.user.email,
                              ));
                          Log.out("ProductReserved",
                              "onReservedClick(add : ${
                                  product.toString()})");
                        },
                        child: Text("    RESERVER    ")
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            side: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor
                            )
                          //minimumSize: ,
                        ),
                        onPressed: (){
                          Navigator.push(context, ShopInfoScreen.route(
                              shop: shop,
                              onMapClick: (){
                                Navigator.push(context, MapSample.route(
                                  initialPosition: shop.location,
                                ));
                              }

                          ));
                        },
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.shopify),
                            SizedBox(width: 8.0,),
                            Text("Boutique")
                          ],
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

