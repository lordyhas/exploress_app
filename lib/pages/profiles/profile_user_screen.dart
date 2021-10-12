part of '../profiles.dart';

class ProfileUserScreen extends StatelessWidget {
  const ProfileUserScreen();

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(color: Colors.black45);
    return BlocBuilder<AuthenticationBloc,AuthenticationState>(
      builder: (context, state){
        Uint8List photoBlob = state.user.photoCloud?.bytes ?? Uint8List.fromList(<int>[]);
        switch(state.status){
          case AuthenticationStatus.authenticated:

            return Scaffold(
              ///extendBodyBehindAppBar: true,
              appBar: AppBar(
                ///backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Text("Profile"),
                actions: [
                  IconButton(icon: Icon(Icons.message), onPressed: (){}),
                  IconButton(icon: Icon(Icons.notifications), onPressed: (){}),
                ],
              ),
              body: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[

                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                          return Container(
                            ///padding: EdgeInsets.only(top: 94.0),
                            color: Theme.of(context).primaryColor,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: BooleanBuilder(
                                      check: true, //state.user.photoMail != null,
                                      ifFalse: Image.asset(
                                        'assets/img/profile1.png',
                                        height: 175,
                                        color: Theme.of(context).primaryColorDark,
                                      ),
                                      ifTrue: BooleanBuilder(
                                          check: photoBlob.isNotEmpty,
                                          ifFalse: Image.asset(
                                              //state.user.photoMail!
                                              'assets/img/profile1.png',
                                              /*'assets/img/profile1.png'*/
                                            height: 150,
                                            color: Theme.of(context).primaryColorDark,
                                          ),
                                          ifTrue: Image.memory(
                                              photoBlob,
                                            //height: 105,
                                            fit: BoxFit.cover,
                                            //color: Colors.blue,
                                          )
                                      ),
                                    ),
                                    //Image.network((state.user.photoMail)!,),
                                    /*CachedNetworkImage(
                                imageUrl: state.user.photo,
                                placeholder: (context, url) => Container(
                                    height: 100,
                                    child: Image.asset("assets/img/profile1.png", color: Colors.white,)
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error, size: 100,),
                              ),*/
                                    /*StreamBuilder(
                                stream: _getOnlineImageProfile(state.user.photo).asStream(),
                                builder: (context, snapshot){
                                  if(!snapshot.hasData)
                                    return Image.asset("assets/img/profile1.png",);
                                  return Image.network(snapshot.data,
                                    loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null ?
                                          loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                              : null,
                                        ),
                                      );
                                    },
                                  );
                                },
                              )*/

                                  ),
                                ),
                                Text(state.user.name ?? "Unknown", style: TextStyle(fontSize: 18),),
                                Text('${state.user.email}'),
                                SizedBox(height: 16,)
                              ],
                            ),
                          );
                        },
                          childCount: 1,
                          addSemanticIndexes: false,

                        ),

                      ),
                    ),


                  ];
                },
                body: SingleChildScrollView(
                  //physics: bounc,
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),

                    child: Column(
                      children: [
                        SizedBox(height: 32.0,),

                        //ListTile(title: Text("Photos", style: TextStyle(fontSize: 18),),),
                        Container(

                          //margin: EdgeInsets.symmetric(horizontal: 8.0),
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ]
                          ),
                          child: Column(
                            children: [
                              OpenContainer(
                                closedColor: Colors.white70,
                                closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                ),
                                transitionDuration: const Duration(milliseconds: 500),
                                closedBuilder: (ctx, action) => Container(
                                  child: ListTile(
                                    leading: Icon(Icons.person_outline_outlined,
                                      color: _textStyle.color,
                                    ),
                                    title: Text("Account", style: _textStyle,),
                                    trailing: Icon(Icons.arrow_forward_ios,
                                      color: _textStyle.color,
                                    ),

                                  ),
                                ),
                                openBuilder: (ctx,action) => EditorProfile(),
                              ),
                              SizedBox(height: 4.0,),

                              ///Address

                              OpenContainer(
                                closedColor: Colors.white70,
                                closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                ),
                                transitionDuration: const Duration(milliseconds: 500),
                                closedBuilder: (ctx, action) => Container(
                                  child: ListTile(
                                    leading: Icon(Icons.location_on_outlined,
                                      color: _textStyle.color,
                                    ),
                                    title: Text("Address", style: _textStyle,),
                                    trailing: Icon(Icons.arrow_forward_ios,
                                      color: _textStyle.color,
                                    ),
                                  ),
                                ),
                                openBuilder: (ctx,action) => defaultScreen(
                                  //container: AddressScreenContainer(),
                                ),
                              ),



                            ],
                          ),
                        ),
                        SizedBox(height: 16,),
                        //ListTile(title: Text("Comments", style: TextStyle(fontSize: 18),),),
                        ///
                        Container(
                          //margin: EdgeInsets.symmetric(horizontal: 8.0),
                          padding: EdgeInsets.all(4.0),

                          decoration: BoxDecoration(
                            //color: Theme.of(context).scaffoldBackgroundColor,
                              color: Colors.grey[400],

                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ]
                          ),
                          //margin: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Column(
                            children: [

                              /*OpenContainer(
                                  closedColor: Colors.white70,
                                  closedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0)
                                  ),
                                  transitionDuration: const Duration(milliseconds: 500),
                                  closedBuilder: (ctx, action) => Container(
                                    child: ListTile(
                                      leading: Icon(Icons.shopping_bag_outlined,
                                        color: _textStyle.color,
                                      ),
                                      title: Text("Order", style: _textStyle,),
                                      trailing: Icon(Icons.arrow_forward_ios,
                                        color: _textStyle.color,
                                      ),
                                    ),
                                  ),
                                  openBuilder: (ctx,action) => defaultScreen()
                              ),
                              SizedBox(height: 4.0,),*/

                              OpenContainer(
                                closedColor: Colors.white70,
                                closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                ),
                                transitionDuration: const Duration(milliseconds: 500),
                                closedBuilder: (ctx, action) => Container(
                                  child: ListTile(
                                    leading: Icon(Icons.credit_card,
                                      color: _textStyle.color,),
                                    title: Text("Payment", style: _textStyle,),
                                    trailing: Icon(Icons.arrow_forward_ios,
                                      color: _textStyle.color,),
                                  ),
                                ),
                                openBuilder: (ctx,action) => defaultScreen(),
                              ),
                              SizedBox(height: 4.0,),

                              OpenContainer(
                                closedColor: Colors.white70,
                                closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                ),
                                transitionDuration: const Duration(milliseconds: 500),
                                closedBuilder: (ctx, action) => Container(
                                  child: ListTile(
                                    leading: Icon(Icons.notifications_none_rounded,
                                      color: _textStyle.color,),
                                    title: Text("Notification", style: _textStyle,),
                                    trailing: Icon(Icons.arrow_forward_ios,
                                      color: _textStyle.color,),
                                  ),
                                ),
                                openBuilder: (ctx,action) => defaultScreen(),
                              ),
                              //SizedBox(height: 4.0,),

                              /*OpenContainer(
                                closedColor: Colors.white70,
                                closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                ),
                                transitionDuration: const Duration(milliseconds: 500),
                                closedBuilder: (ctx, action) => Container(
                                  child: ListTile(
                                    leading: Icon(Icons.favorite_border_outlined,
                                      color: _textStyle.color,),
                                    title: Text("Favorite", style: _textStyle,),
                                    trailing: Icon(Icons.arrow_forward_ios,
                                      color: _textStyle.color,),
                                  ),
                                ),
                                openBuilder: (ctx,action) => defaultScreen(),
                              ),*/
                              SizedBox(height: 4.0,),

                              OpenContainer(
                                closedColor: Colors.white70,
                                closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                ),
                                transitionDuration: const Duration(milliseconds: 500),
                                closedBuilder: (ctx, action) => Container(
                                  child: ListTile(
                                    leading: Icon(Icons.message,
                                      color: _textStyle.color,),
                                    title: Text("Message", style: _textStyle,),
                                    trailing: Icon(Icons.arrow_forward_ios,
                                      color: _textStyle.color,),
                                  ),
                                ),
                                openBuilder: (ctx,action) => defaultScreen(),
                              ),
                              SizedBox(height: 4.0,),

                              OpenContainer(
                                closedColor: Colors.white70,
                                closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                ),
                                transitionDuration: const Duration(milliseconds: 500),
                                closedBuilder: (ctx, action) => Container(
                                  child: ListTile(
                                    leading: Icon(Icons.info_outline_rounded,
                                      color: _textStyle.color,),
                                    title: Text("About Us", style: _textStyle,),
                                    trailing: Icon(Icons.arrow_forward_ios,
                                      color: _textStyle.color,),
                                  ),
                                ),
                                openBuilder: (ctx,action) => AboutPage(),
                              ),
                              SizedBox(height: 4.0,),

                              OpenContainer(
                                closedColor: Colors.white70,
                                closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                ),
                                transitionDuration: const Duration(milliseconds: 500),
                                closedBuilder: (ctx, action) => Container(
                                  child: ListTile(
                                    leading: Icon(Icons.logout,
                                      color: _textStyle.color,),
                                    title: Text("Sign Out", style: _textStyle,),
                                    trailing: Icon(Icons.arrow_forward_ios,
                                      color: _textStyle.color,),
                                  ),
                                ),
                                openBuilder: (ctx,action) => defaultScreen(),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 16.0,)
                      ],
                    ),
                  ),
                ),
              ),
            );
          //case AuthenticationStatus.unknown:
          default:
            //Navigator.pushReplacement(context, LoginPage.route());
            //Navigator.pushAndRemoveUntil(context, LoginPage.route(), (route) => true);
            return Container();

        }
      },
    );
  }

  Widget defaultScreen({Container? container}) => Scaffold(
    appBar: AppBar(),
    body: container != null ? container: Container(
      alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.emoji_emotions_outlined, size: 120, color: Colors.black,),
            Text("Coming Soon", style: TextStyle(fontSize: 20),),
          ],
        ),
    ),
  );


}




