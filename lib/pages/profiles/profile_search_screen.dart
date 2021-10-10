part of '../profiles.dart';



class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  var searchData;
  late StreamController<List<ProductData>> _searchStream;
  FirebaseManager firebaseManager = FirebaseManager();

  @override
  void initState() {
    super.initState();
    _searchStream = StreamController<List<ProductData>>.broadcast();

  }

  @override
  void dispose() {
    _searchStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //int i = -1;
    List<String> names = [
      "Sac à main",
      "Jeans",
      "Smart Watch",
      "Basket blanc noir",
      "Montre noir",
      "Basket blanc",
      "Sac Cuir",
      "Basket Sport",
    ];
    var text =  BlocProvider.of<LanguageBloc>(context).state.getStrings();

    return FutureBuilder<List<ProductData>>(
      /// todo: change this expensive methode
      future: firebaseManager.getAllProduct(),
      builder: (context, snapshot) {
        int i = -1;
        return Container(
          child: Column(
            children: [
              AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: Navigator.of(context).pop,
                ),
                automaticallyImplyLeading: false,
                title: Text("Search",style: Theme.of(context).textTheme.headline6,),
                actions: [
                  IconButton(
                    tooltip: text['tooltip_search'],
                    icon: Icon(Icons.search),
                    onPressed: () {
                      /*final selected = await */showSearch<ProductData?>(
                        context: context,
                        delegate: //ProductSearchDelegate(list),
                        ExploressSearchDelegate(
                          !snapshot.hasData
                              ? <ProductData>[ ]
                              : <ProductData>[...snapshot.data! ],
                            history: !snapshot.hasData
                                ? <ProductData>[ ]
                                : <ProductData>[...snapshot.data!.getRange(0, 3).toList() ],
                        )
                      );
                      //if(selected != null) print('Search : $selected');
                      //_searchStream.add([selected!]);
                    },
                  )
                ],
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Chip(label: Text("#Smartphone")),
                            SizedBox(width: 2.0,),
                            Chip(label: Text("#Tablette")),
                            SizedBox(width: 2.0,),
                            Chip(label: Text("#R-Max")),
                            SizedBox(width: 2.0,),
                            Chip(label: Text("#Veste")),
                            SizedBox(width: 2.0,),
                            Chip(label: Text("#Samsung")),
                            SizedBox(width: 2.0,),
                            Chip(label: Text("#hp")),
                            SizedBox(width: 2.0,),
                            Chip(label: Text("#Airpod")),
                            SizedBox(width: 2.0,),
                            Chip(label: Text("#Veste")),
                            SizedBox(width: 2.0,),
                          ],
                        ),
                      ),

                      //if(snapshot.hasData)
                      Builder(
                        builder: (BuildContext context) {
                          if(snapshot.hasData)
                            return Container(
                              child: Expanded(
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Wrap(
                                      //spacing: 4.0,
                                      //clipBehavior: Clip.antiAlias,
                                      //crossAxisAlignment: WrapCrossAlignment.center,
                                      alignment: WrapAlignment.center,
                                      //runAlignment: WrapAlignment.center,
                                      children:  snapshot.data!.map((product){
                                        i++;
                                        if(!(i==4))
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Card(
                                              //shape: ,
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.all(8.0)
                                                          .copyWith(bottom: 16.0),
                                                      width: (MediaQuery.of(context).size.width) * 0.40,
                                                      height: 150,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                        child: Image.memory(product.image!.bytes),
                                                        //Image.asset('assets/img/p1/product_${i + 1}.png'),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: (MediaQuery.of(context).size.width) * 0.40,
                                                      child: ListTile(
                                                        title: RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  color: Colors.black54
                                                              ),
                                                              children: [
                                                                TextSpan(text: "${product.productName}\n"),
                                                                TextSpan(text: "à ${product.price} \$\n"),
                                                                TextSpan(text: "${product.stockNumber} en stock\n"),
                                                                //TextSpan(text: "\n ${e.}"),

                                                              ]
                                                          ),

                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        return Container(
                                          height: 80,
                                          width: (MediaQuery.of(context).size.width)*0.92,
                                          child: Card(
                                            child: ListTile(
                                              leading: Card(
                                                child: Image.memory(product.image!.bytes,
                                                  //height: 75,
                                                  //width: 75,
                                                ),
                                                //Image.asset('assets/img/p1/product_${i + 1}.png'),
                                              ),
                                              title: Container(
                                                //padding: EdgeInsets.only(top: 2.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                      style: TextStyle(
                                                          color: Colors.black54
                                                      ),
                                                      children: [
                                                        TextSpan(text: "Nom du produit : ${product.productName}\n"),
                                                        TextSpan(text: "Prix : ${product.price} \$\n"),
                                                        TextSpan(text: "${product.stockNumber} en stock\n"),
                                                        //TextSpan(text: "\n ${e.}"),

                                                      ]
                                                  ),

                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      /*List<Widget>.generate(list.length,
                                            (i){
                                              if(!(i==4))
                                                return ClipRRect(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  child: Card(
                                                    //shape: ,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.all(8.0)
                                                              .copyWith(bottom: 16.0),
                                                          width: (MediaQuery.of(context).size.width)*0.41,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            child: Image.asset('assets/img/p1/product_${i + 1}.png'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              return Container(
                                                height: 100,
                                                child: Card(
                                                  child: ListTile(
                                                    leading: Card(
                                                      child: Image.asset('assets/img/p1/product_${i + 1}.png'),
                                                    ),
                                                    title: Text("Product $i"),
                                                  ),
                                                ),
                                              );
                                            }),*/

                                    ),
                                  ),
                                ),
                              ),
                          );

                          return Container(
                            alignment: Alignment.center,
                            child: Center(child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                             ),
                            ),
                          );
                        },

                      ),

                    ],
                  ),
                ),

                /*Container(
                  child: SingleChildScrollView(
                    child: StreamBuilder<List<String>>(
                      stream: _searchStream.stream,
                      builder: (context, snapshot) {
                        //var r;
                        if(snapshot.hasData){
                          if(snapshot.data!.isNotEmpty)
                            List<Widget>.generate(snapshot.data!.length,
                                    (i) => ListTile(
                                      leading: Icon(Icons.label_important),
                                      title: Text('${snapshot.data![i]}'),
                                    )
                            );
                        }
                        return Container();
                      }
                    )
                  ),
                ),*/
              )
            ],
          ),
        );
      }
    );
  }


}