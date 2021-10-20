part of '../profiles.dart';


class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key}) : super(key: key);
  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}
class _ShoppingScreenState extends State<ShoppingScreen> {
  bool swipe = false;
  FirebaseManager _firebaseManager = FirebaseManager();


  late List<ProductData> products;


  @override
  void initState() {
    super.initState();
    //todo : implement method below
    //_getProductFromReserved();
  }

 /* void _getProductFromReserved() async {
    List<ReservedProduct> reservedProducts = context
        .read<ShoppingCartBloc>().state.reservedProducts;
    List<ProductData> productList = [];
    for (var res in reservedProducts) {
       //var prod = await _firebaseManager.getProductFromReserved(reserved: res);
       productList.add(await _firebaseManager.getProductFromReserved(reserved: res));
    }
    assert(productList.length == reservedProducts.length, "Error ShoppingScreen");
    products = productList;

  }*/


  @override
  Widget build(BuildContext context) {
    var _tabBar = <Tab>[
      Tab(
        icon: Icon(Icons.shopping_bag_outlined),
        text: "Reservation",
      ),
      /*Tab(
        icon: Icon(Icons.shopping_cart_outlined),
        text: "Wishlist",
      ),*/

      Tab(
        icon: Icon(Icons.favorite_border_outlined),
        text: "Favoris",
      ),
    ];
    return Container(
      //height: 400,
      //width: 200,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Reservation",
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: [
            /*Switch(
              value: swipe,
              onChanged: (value){

              },

            ),*/
          ],
          bottom: TabBar(
            labelColor: Theme.of(context).primaryColorLight,
            indicatorColor: Theme.of(context).primaryColorLight,
            tabs: _tabBar,
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: Stack(
                children: [

                  Container(
                    child: DismissReservedList(
                      canSwipe: !swipe,
                      reservedProductList: context.read<ShoppingCartBloc>().state.reservedProducts,
                      productList : List<ProductData>.generate(7,
                              (i) => ProductData(
                            productCode: 'Prod(Ox'+DateTime.now()
                                .microsecondsSinceEpoch.toString()+')',
                            productName: "Product ${i + 1}",
                            shopCode: '',
                            price:  (5 + Random(i).nextInt(200)).toDouble(),
                            stockNumber:  1 + Random(i).nextInt(10),

                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      //height: 100,
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width - 10,
                      child: SwitchListTile(
                        title: Text('active swipe',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: swipe,
                        onChanged: (bool value) {
                          setState(() {
                            swipe = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /*Container(
              child: Wishlist(
                reservedProductList: context.read<ShoppingCardBloc>().state.reservedProducts,
                productList : List<ProductData>.generate(7,
                        (i) => ProductData(
                      productCode: 'Prod(Ox'+DateTime.now()
                          .microsecondsSinceEpoch.toString()+')',
                      productName: "Product ${i + 1}",
                      shopCode: '',
                      price:  5 + Random(i).nextInt(200),
                      stockNumber:  1 + Random(i).nextInt(10),

                    )),
              ),
            ),*/

            Container(
              child: FavoriteList(
                reservedProductList: context.read<ShoppingCartBloc>().state.reservedProducts,
                productList : List<ProductData>.generate(
                    context.read<ShoppingCartBloc>().state.reservedProducts.length,
                        (i) => ProductData(
                      productCode: 'Prod(Ox'+DateTime.now()
                          .microsecondsSinceEpoch.toString()+')',
                      productName: "Product ${i + 1}",
                      shopCode: '',
                      price:  (5 + Random(i).nextInt(200)).toDouble(),
                      stockNumber:  1 + Random(i).nextInt(10),

                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

class DismissReservedList extends StatefulWidget {
  final List<ReservedProduct> reservedProductList;
  final List<ProductData> productList;
  final bool canSwipe;
  const DismissReservedList({
    Key? key,
    this.canSwipe = false,
    this.reservedProductList = const [],
    this.productList = const [],
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DismissReservedListState();
  }
}

class _DismissReservedListState extends State<DismissReservedList> {
  List<bool> checkSelectCartList = List<bool>.generate(7, (index) => false);
  late final List<ReservedProduct> reservedList;
  // todo : increment quantity in Firestore
  late final List<ProductData> products;
  final bool validate = false;
  late Color colorVal;


  @override
  void initState() {
    super.initState();
    reservedList = widget.reservedProductList;
    products = widget.productList;

  }

  Future<void> dialogDetailProduct(List<ProductData> prods, int index){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Title XXXXX", style:  TextStyle( color: Colors.black87),),
        content: Container(
          height: 200,
          child: Column(
            children: [
              Card(
                child: Container(
                  height: 20,
                  child: Placeholder(),
                ),
              ),
              Card(
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 30,
                          width: 20,
                          child:  Placeholder(),
                        ),
                        const SizedBox(
                          height: 30,
                          width: 20,
                          child:  Placeholder(),
                        ),
                        const SizedBox(
                          height: 30,
                          width: 20,
                          child:  Placeholder(),
                        ),
                         const SizedBox(
                          height: 30,
                          width: 20,
                          child:  Placeholder(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(prods[index].productName),
              const Text("\nTest test test test test test"),
              const Text("With regards to this project, each group is "
                  "required to choose an organisation/company/entity in "
                  "theirsurroundings and consider their digital landscape. "
                  "You must consider the needs and requirements."),
            ],
          ),
        ),
      ),

    );
  }



  @override
  Widget build(BuildContext context) {
    if(context.read<StyleAppTheme>().isDarkMode)
      colorVal  = Theme.of(context).primaryColor;
    else colorVal  = Theme.of(context).primaryColorLight;
    return ListView.separated(
      padding: const EdgeInsets.only(top: 52,),
      itemCount: products.length,
      separatorBuilder: (context, index){
        return Container(); //Divider(indent: 32,endIndent: 32,);
      },
      itemBuilder: (context, index) {
        final item = products[index];
        // Each Dismissible must contain a Key. Keys allow Flutter to uniquely
        // identify Widgets.
        return InkWell(
          onTap: () => dialogDetailProduct(products, index),
          child: AbsorbPointer(
            absorbing: widget.canSwipe,
            child: Dismissible(
              key: Key(item.productCode+'pro'),
              //direction: DismissDirection.none,
              direction: DismissDirection.horizontal ,
              /*direction: (widget.canSwipe)
                  ? DismissDirection.none
                  : DismissDirection.horizontal ,*/
              // We also need to provide a function that tells our app what to do
              // after an item has been swiped away.
              onDismissed: (DismissDirection dir) {
                setState(() {
                  this.checkSelectCartList.removeAt(index);
                  this.products.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 7),
                    content: Text(dir == DismissDirection.startToEnd
                        ? '${item.productName} removed.'
                        : '${item.productName} finished.'),
                    action: SnackBarAction(
                      textColor: Theme.of(context).primaryColorLight,
                      label: 'UNDO',
                      onPressed: () {
                        setState(() {
                          this.checkSelectCartList.insert(index, false);
                          this.products.insert(index, item);
                          });
                      },
                    ),
                  ),
                );

              },
              // Show a red background as the item is swiped away
              background: Container(
                //width: 200,
                padding: const EdgeInsets.only(left: 8.0),
                color: Colors.red,
                child: Row(
                  children: [
                    const Icon(Icons.delete_forever_outlined, size: 52),
                    const SizedBox(width: 4.0,),
                    const Text('Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
              ),
              /// Background when swipping from right to left
              secondaryBackground: Container(
                //width: 200,
                padding : const EdgeInsets.only(right: 8.0),
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Already',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 4.0,),
                    const Icon(Icons.check_circle_outline, size: 52),
                  ],
                ),
                alignment: Alignment.centerRight,
              ),
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        /*value: checkSelectCartList[index],
                        onChanged: (value){
                          setState(() {
                            checkSelectCartList[index] = value!;
                          });

                        },*/
                        key: Key(item.productCode),
                        trailing: (reservedList[index].isReserved)
                            ? const Icon(Icons.done, color: Colors.grey,)
                            :  Icon(Icons.done_all,color: colorVal  ),
                        leading: const Icon(Icons.shopping_cart_outlined),
                        title: Text("${products[index].productName}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!.copyWith(fontSize: 18),
                        ),
                      ),
                      Container(
                        height: 100,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 8.0),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      //width: 2.0,
                                      color:Theme.of(context).primaryColorLight,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/img/p1/product_${index + 1}.png'),
                                    ),
                                  ),

                                ),
                                Expanded(
                                  child: Container(
                                    height: 80,
                                    child: ListTile(

                                      title: RichText(
                                        text: TextSpan(
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          children: [
                                            TextSpan(
                                                text: "Price : "
                                                    "\$${products[index].price}"
                                            ),
                                            TextSpan(
                                                text:"\nQuantity : "
                                                    "${reservedList[index].quantity}"
                                            ),
                                            TextSpan(
                                                text:"\nExpiration date : ${
                                                    DateTime.now()
                                                    .add(Duration(days: 3))
                                                    .toString().substring(0,10)
                                            }" ),
                                            TextSpan(
                                                text: "\n",//${products[index].category}
                                            ),
                                          ]
                                      ),),

                                      /*Text(
                                          "Price : \$${_items[index].price}"
                                          "\nQuantity : ${_items[index].stockNumber}"
                                          "\nExpiration date : ${
                                              DateTime.now()
                                                  .add(Duration(days: 3))
                                                  .toString().substring(0,10)
                                          }"
                                          "\nWaiting for validation..."

                                      ),*/
                                      subtitle: Text((reservedList[index]
                                          .isReserved)
                                          ? "Waiting for validation..."
                                          : "Product has been reserved.",
                                        style: Theme.of(context).textTheme.bodyText2,),
                                    ),
                                  ),
                                ),
                                /*Expanded(
                                  child: Container(
                                    height: 70,
                                    //width: 70,
                                    child: Column(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      //mainAxisSize: MainAxisSize.,
                                      //verticalDirection: VerticalDirection.up,
                                      children: [
                                        Column(
                                          children: [
                                            Text("Text text ",),
                                          ],
                                        ),
                                        Column(
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("\$50.0",),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),*/
                              ],
                            ),
                            ///Text("${_items[index].price}")
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          for (var i = 0; i < 6; ++i)
                            Container(
                              height: 30,
                              width: 50,
                              child:  Placeholder(
                                color: !(reservedList[index].isReserved)
                                    ? colorVal
                                    : Colors.grey,
                              ),
                            ),

                            /*Container(
                              width: 30,
                              child: Icon(Icons.check, color: Colors.grey,),
                            )*/
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}




class Wishlist extends StatelessWidget {
  final List<ReservedProduct> reservedProductList;
  final List<ProductData> productList;
  const Wishlist({
    Key? key,
    this.reservedProductList = const [],
    this.productList = const [],
  }) :  assert(reservedProductList.length == productList.length, "Error 1547"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          itemCount: 5,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(indent: 32,endIndent: 32,);
          },
          itemBuilder: (context, index) => Container(
            child: Card(
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      key: Key('key+$index'),
                      trailing: Icon(Icons.shopping_cart_outlined),
                      title: Text("${productList[index].productName}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2,
                      ),
                    ),
                    Container(
                      height: 100,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8.0),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    //width: 2.0,
                                    color:Theme.of(context).primaryColorLight,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: AssetImage('assets/img/p1/product_${index + 1}.png'),
                                  ),
                                ),

                              ),
                              Expanded(
                                child: Container(
                                  height: 80,

                                  child: ListTile(

                                    title: RichText(
                                      text: TextSpan(
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          children: [
                                            TextSpan(
                                                text: "Price : "
                                                    "\$${productList[index].price}"
                                            ),
                                            TextSpan(
                                                text:"\nQuantity : "
                                                    "${reservedProductList[index].quantity}"
                                            ),
                                            TextSpan(
                                                text:"\nExpiration date : ${
                                                    DateTime.now()
                                                        .add(Duration(days: 3))
                                                        .toString().substring(0,10)
                                                }" ),
                                            TextSpan(
                                                text: "\nWaiting for validation..."
                                            ),
                                          ]
                                      ),),

                                    /*Text(
                                          "Price : \$${_items[index].price}"
                                          "\nQuantity : ${_items[index].stockNumber}"
                                          "\nExpiration date : ${
                                              DateTime.now()
                                                  .add(Duration(days: 3))
                                                  .toString().substring(0,10)
                                          }"
                                          "\nWaiting for validation..."

                                      ),*/
                                    subtitle: Text("\$50.0",
                                      style: Theme.of(context).textTheme.bodyText1,),
                                  ),
                                ),
                              ),
                              /*Expanded(
                                  child: Container(
                                    height: 70,
                                    //width: 70,
                                    child: Column(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      //mainAxisSize: MainAxisSize.,
                                      //verticalDirection: VerticalDirection.up,
                                      children: [
                                        Column(
                                          children: [
                                            Text("Text text ",),
                                          ],
                                        ),
                                        Column(
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("\$50.0",),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),*/
                            ],
                          ),
                          ///Text("${_items[index].price}")
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 50,
                            child:  Placeholder(),
                          ),
                          Container(
                            height: 30,
                            width: 50,
                            child:  Placeholder(),
                          ),
                          Container(
                            width: 30,
                            child: Icon(Icons.check, color: Colors.grey,),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}


class FavoriteList extends StatelessWidget {
  final List<ReservedProduct> reservedProductList;
  final List<ProductData> productList;
  const FavoriteList({
    Key? key,
    this.reservedProductList = const [],
    this.productList = const [],
  }) :  assert(reservedProductList.length == productList.length, "Error FavoriteList"),
        super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: 5,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(indent: 32,endIndent: 32,);
        },
        itemBuilder: (context, index) => Container(
          child: Card(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    key: Key('key+$index'),
                    leading: Icon(Icons.dehaze_rounded),
                    trailing: Icon(Icons.favorite,
                      color: Theme.of(context).primaryColor,),
                    title: Text("${productList[index].productName}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!.copyWith(fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 100,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 8.0),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2.0,
                                  color:Theme.of(context).primaryColorLight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage('assets/img/p1/product_${index + 1}.png'),
                                ),
                              ),

                            ),
                            Expanded(
                              child: Container(
                                height: 80,

                                child: ListTile(

                                  title: RichText(
                                    text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        children: [
                                          TextSpan(
                                              text: "Price : "
                                                  "\$${productList[index].price}"
                                          ),
                                          TextSpan(
                                              text:"\nQuantity : "
                                                  "${reservedProductList[index].quantity}"
                                          ),
                                          TextSpan(
                                              text:"\nExpiration date : ${
                                                  DateTime.now()
                                                      .add(Duration(days: 3))
                                                      .toString().substring(0,10)
                                              }" ),

                                        ]
                                    ),),


                                  subtitle: Text("Stock : ${productList[index].stockNumber}",
                                    style: Theme.of(context).textTheme.bodyText2,),
                                ),
                              ),
                            ),

                          ],
                        ),
                        ///Text("${_items[index].price}")
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}