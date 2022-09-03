import 'dart:math' as math;

import 'package:exploress/data/app_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DescriptionContent extends StatefulWidget {
  final ProductData productData;
  final imagePath;

  //final String productName;
  //final int price;
  Size? size;
  final void Function() onFavoriteClick;
  final void Function() onReservedClick;
  final void Function() onPressed;

  DescriptionContent({
    required this.onFavoriteClick,
    required this.onReservedClick,
    required this.onPressed,
    required this.productData,
    this.imagePath,

    Key? key,
  }) : super(key: key);

  @override
  _DescriptionContentState createState() => _DescriptionContentState(
      price: this.productData.price, product: this.productData.productName);

  set setSize(Size? size) => this.size = size;
}

class _DescriptionContentState extends State<DescriptionContent> {
  bool v = false;

  final String product;
  final double price;

  _DescriptionContentState({required this.product, required this.price});

  @override
  Widget build(BuildContext context) {
    double x = 0.6 * 350;
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        height: widget.size?.height ?? x,
        width: widget.size?.width ?? x,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              title: Text(
                product,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              subtitle: Text(
                "\$$price",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Container(
              //color: Colors.blueGrey,
              //padding: EdgeInsets.symmetric(horizontal: 8.0),
              padding: EdgeInsets.only(left: 16.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //width: 100,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        textStyle: TextStyle(color: Colors.deepOrange),
                        //shape: ,
                        side: BorderSide(width: 1.5, color: Colors.deepOrange),
                        padding: EdgeInsets.all(0.0),
                      ),
                      //splashColor: Colors.blueAccent,
                      onPressed: widget.onReservedClick,

                      child: Text(
                        "Reserver",
                        style: TextStyle(
                            fontSize: 16.0, color: Colors.deepOrange),
                      ),
                    ), /*ListTile(title: Text("Reserver",
                        style: TextStyle(color: Colors.lightBlue),),)*/
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        v = !v;
                      });
                      return widget.onFavoriteClick();
                    },
                    icon: (!v)
                        ? Icon(
                            Icons.favorite_border,
                            color: Theme.of(context).accentColor,
                          )
                        : Icon(
                            Icons.favorite,
                            color: Theme.of(context).primaryColor,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ParallaxViewPager extends StatefulWidget {
  final int defaultIndex;

  //final List<String>? imagePathList;
  final List<DescriptionContent> children;

  //DescriptionText(product: "Product", price: 50,)

  ParallaxViewPager({
    //this.imagePathList,
    required this.children,
    this.defaultIndex = 0,
    Key? key,
  }) : super(key: key);

  //: assert(imagePathList.length == children.length);

  @override
  _ParallaxViewPagerState createState() => _ParallaxViewPagerState();
}

class _ParallaxViewPagerState extends State<ParallaxViewPager> {
  late PageController pageController;

  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    //pageOffset = widget.defaultIndex;
    pageController = PageController(viewportFraction: 0.60);
    //pageController?.viewportFraction;
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page!;
        //print('pageOffset : ${pageController.page}');
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double adjust = 320;
    return Container(
      height: 260, //MediaQuery.of(context).size.height * 0.4,
      child: PageView.builder(
        controller: pageController,
        itemBuilder: (context, index) {
          return CardPageWidget2(
            //imagePath: widget.children[index].productData.image,
            image: Hero(
              tag: widget.children[index].productData.productCode,
              child: Image.memory(
                widget.children[index].productData.image!.bytes,
              ),
            ),
            child: widget.children[index],
            //.copyWithSize(Size(0.7 * adjust,0.7 * adjust)),
            offset: pageOffset - index,
          );
        },
        itemCount: widget.children.length - 1,
      ),
    );
  }
}

class CardPageWidget2 extends StatelessWidget {
  final double offset;

  //final String imagePath;
  final Widget image;
  final Widget child;

  CardPageWidget2(
      { required this.image,
      required this.offset,
      //required this.imagePath,
      required this.child, Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double radius = 20;
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 6.0,
        color: Colors.transparent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        child: Stack(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(radius),
                  bottom: Radius.circular(radius),
                ),
                child:
                    image /*Image.asset(
                imagePath,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.fill,
              ),*/
                ),
            //SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Container(
                child: Transform.translate(
                  offset: Offset(
                      -offset * MediaQuery.of(context).size.width / 2, -25),
                  child: Container(
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class CardPageWidget extends StatelessWidget {
  final double offset;
  final String imagePath;
  final Widget child;

  CardPageWidget(
      {required this.offset, required this.imagePath, required this.child});

  @override
  Widget build(BuildContext context) {
    double radius = 32;
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 4,
        shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              //height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(radius),
                  //bottom: Radius.circular(radius),
                ),
                child: Image.asset(
                  imagePath,
                  alignment: Alignment(-offset.abs(), 0),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Transform.translate(
                offset:
                    Offset(-offset * MediaQuery.of(context).size.width / 2, 0),
                child: Container(
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
