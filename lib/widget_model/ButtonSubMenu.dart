import 'dart:io';

import 'package:exploress/data/values/strings.dart';
import 'package:exploress/pages/product_page.dart';
import 'package:exploress/pages/shop_page.dart';
//import 'package:exploress/pages/shop/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils_component/utils_component.dart';
import 'BooleanBuilder.dart';
//enum SubListType{home, shop, product, more, option}
enum SubListType{shop, product, more, restaurant}


class ButtonSubMenu extends StatefulWidget {
  final String title;
  final SubListType subListType;
  final Color? color;
  final double sizeWidth;
  final bool isWeb;

  ButtonSubMenu({
    required this.title,
    required this.subListType,
    this.color,
    this.sizeWidth = 150,
    this.isWeb = false,
  }) ;

  @override
  _ButtonSubMenuState createState() => _ButtonSubMenuState();
}

class _ButtonSubMenuState extends State<ButtonSubMenu> {
  List<String>? listWord;
  var text;
  Map<String, List<String>> dataSubList ={};
  bool? check;

  @override
  void initState(){
    super.initState();

  }

  setSystemUIForProductDesign() => SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        //statusBarColor: Colors.transparent,
        //statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).primaryColorLight,
      )
  );

  setSystemUIForShopDesign() => SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // statusBarColor: Colors.transparent,
    // statusBarIconBrightness: Brightness.dark,
    // statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
    // systemNavigationBarColor: Colors.white,
    // systemNavigationBarDividerColor: Colors.grey,
    // systemNavigationBarIconBrightness: Brightness.dark,
  ));


  @override
  Widget build(BuildContext context) {

    void evenOnClick(String value){
      switch(widget.subListType){
        case SubListType.shop:
          if(value.contains(listWord![1])){
            setSystemUIForShopDesign();
            Navigator.push(context, ShopPage.route());
          }

          /*else if(value.contains(listWord![2])){}
          else if(value.contains(listWord![3])){}
          else if(value.contains(listWord![4])){}*/
          else{
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                    content: Container(
                      //height: 100,
                      //width: 100,
                        child: Text('Shops Coming Soon',
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        )
                    )
                )
            );
          }
          break;
        case SubListType.product:

          if(value.contains(listWord![1])){
            setSystemUIForProductDesign();
            Navigator.push( context, MaterialPageRoute(
              builder: (BuildContext context) => ProductPage(
                title: listWord![1],
              ),),
            );
          }
          /*else if(value.contains(listWord![2])){
            setSystemUIForProductDesign();
            Navigator.of(context).push( MaterialPageRoute(
              builder: (BuildContext context) => ProductPage(
                title: listWord![2],
              ),),
            );
          }
          else if(value.contains(listWord![3])){
            setSystemUIForProductDesign();
            Navigator.of(context).push( MaterialPageRoute(
              builder: (BuildContext context) => ProductPage(
                title: listWord![3],
              ),),
            );
          }
          else if(value.contains(listWord![4])){
            setSystemUIForProductDesign();
            Navigator.of(context).push( MaterialPageRoute(
              builder: (BuildContext context) => ProductPage(
                title: listWord![4],
              ),),
            );
          }*/
          else{
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                    content: Container(
                      //height: 100,
                      //width: 100,
                        child: Text('Products Coming Soon',
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        )
                    )
                )
            );
          }
          break;
        case SubListType.more:
          if(value.contains(listWord![1])){}
          else if(value.contains(listWord![2])){}
          break;
        case SubListType.restaurant:
          if(value.contains(listWord![1])){}
          else if(value.contains(listWord![2])){}
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                  content: Container(
                    //height: 100,
                    //width: 100,
                      child: Text('No Restaurant Yet',
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      )
                  )
              )
          );
          break;
      }
    }
    text =  BlocProvider.of<LanguageBloc>(context).state.getStrings();
    dataSubList = {
      'Shop' : [
        text['shop'],
        text['shop_dress'],
        text['shop_phone'],
        text['shop_com'],
        text['shop_kit'],

      ],
      'Produit' : [
        text['product'],
        text['prod_all'],
        text['prod_elect'],
        text['prod_clo'],
        text['prod_fur'],
      ],
      'restaurant' : [
        text['rest_title'],
        text['rest_collection'],
        text['rest_meal'],
        //text[''],
      ],
      'more': [
        "more",
        text['set_name'],
        text['about'],
      ],
    };
    switch(widget.subListType){
      case SubListType.shop:
        listWord = dataSubList['Shop'];
        break;
      case SubListType.product:
        listWord = dataSubList['Produit'];
        break;
      case SubListType.more:
        listWord = dataSubList['more'];
        break;
      case SubListType.restaurant:
        listWord = dataSubList['restaurant'];
        break;
    }
    String dropdownValue = listWord!.first;
    //listWord.remove(listWord[0]);
   //check = false;
    var childrenItem = List.from(listWord!)..removeAt(0);
    //if(!check) childrenItem.remove(listWord[0]);

    return ContainerBooleanBuilder(
      check: widget.isWeb,
      ifFalse: ExpansionTile(
        //expandedAlignment: Alignment.topRight,
        //key: PageStorageKey<List<String>>(listWord),
        //backgroundColor: Theme.of(context).primaryColor,
        //collapsedBackgroundColor: Theme.of(context).primaryColorLight,
        //trailing: Icon(Icons.add_circle_outline),
        childrenPadding: EdgeInsets.all(2.0),
        title: Text(dropdownValue,style: Theme.of(context).textTheme.subtitle2,),
        children: childrenItem.map(
                (value) => Container(
                  //color: Colors.red,
                  height: 40,
                  child: ListTile(
                    onTap: (){
                      evenOnClick(value);
                    },
                    title: Text(
                      value,
                      style: Theme.of(context).textTheme.subtitle2!
                        .copyWith(color: Theme.of(context).primaryColorLight
                          .withOpacity(0.7)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                )).toList(),
      ),
      ifTrue: Container(
        width: widget.sizeWidth,
        child: ListTile(
          title: DropdownButton<String>(
            value: dropdownValue,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).primaryColorLight,),
            iconSize: 24,
            elevation: 16,
            style: Theme.of(context).textTheme.subtitle2, //TextStyle(color: widget.color ?? Theme.of(context).primaryColorLight,),
            underline: Container(
              height: 2,
              color: widget.color ?? Theme.of(context).primaryColorLight,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
              evenOnClick(dropdownValue);
              /*if(dropdownValue.contains(listWord[1])){
                Navigator.of(context).push( MaterialPageRoute(
                  builder: (BuildContext context) => ProductPage(),),
                );
              }*/
            },
            items: listWord!.map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value), /*InkWell(
                        child: Text(value),
                        onTap: (){},
                        onDoubleTap: (){},
                      ),*/
                    ),
            ).toList(),
          ),
          /*onTap: (){
            setState(() {
              print("Go to Webview -- START --");
            });
          },*/
        ),
      ),
    );
  }
}
