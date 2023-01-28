
// Defines the content of the search page in `showSearch()`.
// SearchDelegate has a member `query` which is the query string.
import 'dart:async';

import 'package:exploress/data/app_bloc_library.dart';
import 'package:exploress/data/app_database.dart';
import 'package:exploress/data/values.dart';
import 'package:exploress/pages/product/quick_single_product.dart';
import 'package:exploress/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart' as dist;
import 'package:utils_component/utils_component.dart';

class ProductSearchDelegate extends SearchDelegate<ProductData?>{
  final List<ProductData> products;
  ProductSearchDelegate(this.products) : super(searchFieldStyle: TextStyle(color: Colors.black38),);
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
            query = "";
        },
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    //super.appBarTheme(context);
    return Theme.of(context);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<ProductData> suggestions = this.products.where((prod) {
      if(prod.productName.toLowerCase().contains(query.toLowerCase())) return true;
      //if(prod.category!.contains(query)) return true;
      //if(prod.subCategory!.contains(query)) return true;
      if(prod.price.toString().contains(query)) return true;
      //if(prod.asMap().containsValue(query)) return true;

      return false;
    });
    return Container(
      child: ListView(
        children: suggestions.map((e) => Text(e.productName)).toList(),
      ),
    );
  }

}

class ExploressSearchDelegate extends SearchDelegate<ProductData?> {
  final List<ProductData> _words;
  final List<ProductData> _history;

  ExploressSearchDelegate(List<ProductData> words, {history = const <ProductData>[]})
      : _words = words,
        _history = history,
        super(searchFieldStyle: const TextStyle(color: Colors.black38),);


  ProductData? _productFind;


  // Leading icon in search bar.
  @override
  Widget buildLeading(BuildContext context) {
    ///appBarTheme();
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //SearchDelegate.close() can return values, similar to Navigator.pop().
        this.close(context, null);
        ///this.close(context, null);
      },
    );
  }

  // Widget of result page.
  @override
  Widget buildResults(BuildContext context) {
    //ProductData? product = this._productFind;
    Size size = MediaQuery.of(context).size;
    var position = BlocProvider.of<MapsBloc>(context).state.maps;
    var textStyle =
    Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20);

    //int index = this._words.indexOf()

    ProductData product = this._words.where((element) => element.productName==query).first;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowProductScreen(product),
    );
  }

  // Suggestions list while typing (this.query).
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<ProductData> suggestions = this.query.isEmpty
        ? _history
        : _words.where((prod) {
          if(prod.productName.toLowerCase().contains(query.toLowerCase())) return true;
          //if(prod.category!.contains(query)) return true;
          //if(prod.subCategory!.contains(query)) return true;
          if(prod.price.toString().contains(query)) return true;
          //if(prod.asMap().containsValue(query)) return true;

          return false;
    });

    return ContainerBooleanBuilder(
      check: this._words.isNotEmpty ,
      ifFalse: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_outlined, color: Colors.black, size: 102,),
            Text('No Internet'),
          ],
        ),
      ),
      ifTrue: _SuggestionList(
        query: this.query,
        suggestions: suggestions.toList(),
        onSelected: (ProductData suggestion) {
          this.query = suggestion.productName;
          this._productFind = suggestion;
          if(this._history.contains(suggestion))
            this._history.remove(suggestion);
          this._history.insert(0, suggestion);
          showResults(context);
          //this.close(context, this._productFind!);
        },
      ),
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty)
        IconButton(
          tooltip: 'Voice Search',
          icon: const Icon(Icons.mic),
          onPressed: () {
            this.query = 'voice input coming soon';
          },
        )
      else
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    //super.appBarTheme(context);
    return Theme.of(context);
    /*return ThemeData(
      primaryColor: Colors.deepPurpleAccent,
      primaryIconTheme: IconThemeData(
        color: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle:
        Theme.of(context).textTheme.title.copyWith(color: Colors.white),
      ),
    );*/
  }

  @override
  void showResults(BuildContext context) {
    super.showResults(context);
    //if(!this._history.contains(this._productFind) && this.query.isNotEmpty)
      //this._history.insert(0, this._productFind);

  }
}

// Suggestions list widget displayed in the search page.
class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<ProductData>? suggestions;
  final String? query;
  final ValueChanged<ProductData>? onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
      itemCount: suggestions!.length,
      itemBuilder: (BuildContext context, int i) {
        final ProductData suggestion = suggestions![i];
        return query!.isEmpty
            ? ListTile(
                leading: const Icon(Icons.history) ,
                // Highlight the substring that matched the query.
                title: RichText(
                  text: TextSpan(
                    text: suggestion.productName,
                    style: textTheme!.copyWith(fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      /*TextSpan(
                        text: suggestion.substring(query!.length),
                        style: textTheme,
                      ),*/
                    ],
                  ),
                ),
                onTap: () {
                  onSelected!(suggestion);
                },
              )
            : Card(
                child: InkWell(
                  onTap: () {
                    onSelected!(suggestion);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              //width: 2.0,
                              color:Theme.of(context).primaryColorLight,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: MemoryImage(suggestion.image!.bytes),
                              //AssetImage('assets/img/p1/product_${i+ 1}.png'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 80,
                            child: ListTile(
                              title: RichText(
                                text: TextSpan(
                                  text: suggestion.productName,
                                  style: textTheme!.copyWith(fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "\nPrice : ${suggestion.price} \$",
                                      style: textTheme,
                                    ),
                                    TextSpan(
                                      text: "\nCategory : ${suggestion.category}",
                                      style: textTheme,
                                    ),
                                    TextSpan(
                                      text: "\n${suggestion.stockNumber} en Stock",
                                      style: textTheme,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
              ),
                ),
            );
      },
    );
  }
}