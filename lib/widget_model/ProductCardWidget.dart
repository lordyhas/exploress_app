
import 'dart:math';


import 'package:exploress/data/app_database.dart';
import 'package:exploress/pages/product/single_product_page.dart';
import 'package:flutter/material.dart';

typedef OnTap = void Function();


class ProductCard extends StatefulWidget {

  final String? productName;
  final heroTag;
  final double? price;
  final int? stock;
  final bool canReserve;
  final String? imagePath;
  final productCode;
  final ProductData product;
  //final Function() onFavoriteTap;
  //final Function() onReservationTap;
  final Function()? onProductTap;


  ProductCard({this.productName, this.price, this.stock, this.canReserve = true,
    this.imagePath, this.productCode, this.heroTag, this.onProductTap, required this.product});

  factory ProductCard.fromProductData({
    required ProductData product,
    Function()? onFavoriteTap,
    Function()? onReservationTap,
    required Function() onProductTap }) => ProductCard(
    heroTag: product.productCode,
    product: product,
    onProductTap: onProductTap,
  );

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  bool isFavorite = false;
  int increment = 0;



  @override
  Widget build(BuildContext context) {
    var product = widget.product;

    //Color iconColor = Colors.lightBlueAccent; //Theme.of(context).primaryColorLight,
    Color iconColor = Theme.of(context).accentColor;
    return Container(
      margin: EdgeInsets.all(8.0,),
      //height: 150, //MediaQuery.of(context).size.height,
      child: Card(
        elevation: 2.0,
        child: Column(
          children: [
            Container(
              child: Container(
                constraints: BoxConstraints(maxHeight: 250),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  onHover: (bool checked){
                    if(checked)
                      print('onHover : ${product.productName} | ${increment++}');
                    },
                    onTap: widget.onProductTap,
                    onDoubleTap: (){
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Hero(
                      tag: widget.heroTag,
                        child: Image.memory(product.image!.bytes)
                    ),
                ),
              ),
            ),
            Divider(height: 1.0, indent: 32.0, endIndent: 32.0,),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(product.productName),
                      subtitle: Text("\$${product.price} | stock : ${product.stockNumber}"),
                      trailing: IconButton(
                        tooltip: " Ajouter aux Produits favoris",
                        icon: (!isFavorite)
                            ? Icon(
                          Icons.favorite_border,
                          color: iconColor, //Theme.of(context).primaryColorLight.withAlpha(200),
                        )
                            : Icon(Icons.favorite,
                          color: Theme.of(context).primaryColor,),
                        onPressed: (){
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(///width: 50,
                    child: IconButton(
                      tooltip: "Faite une reserve",
                      icon: (product.isPossibleReservation == true)
                          ? Icon(Icons.add_shopping_cart,
                        color: iconColor,)
                          : Icon(Icons.remove_shopping_cart_outlined,
                        color: Colors.blueGrey,),
                      onPressed: (product.isPossibleReservation != true)? null :(){},
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


