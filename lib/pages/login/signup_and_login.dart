

import 'package:exploress/data/app_bloc_library.dart';

import '../home_page.dart';
import 'package:flutter/material.dart';


import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

part 'signin_home.dart';
part 'signin_page.dart';
part 'signin_form.dart';
part 'signup_page.dart';
part 'signup_form.dart';
part 'ButtonLoginWidget.dart';



enum DefaultPage { login, signIn, modify }
/*
class SignInAndLoginPage extends StatefulWidget {
  final DefaultPage defaultOpenPage;
  SignInAndLoginPage({required this.defaultOpenPage});

  @override
  _SignInAndLoginPageState createState() => _SignInAndLoginPageState();
}

class _SignInAndLoginPageState extends State<SignInAndLoginPage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SingleChildScrollView(
          child: (widget.defaultOpenPage != DefaultPage.login)
              ? signInScreen(_status)
              : loginScreen(false),
        ));
  }

  Widget _screenByDefaultSignInPageSelected(DefaultPage selected){
    switch(selected){
      case DefaultPage.login:
        return loginScreen(false);
      case DefaultPage.signIn:
        return signInScreen(_status);
      case DefaultPage.modify:
        return signInScreen(_status);
      default:
        return loginScreen(false);
    }
  }

  Widget signInScreen(bool _status){
    return Column(
      children: <Widget>[
        Container(
          height: 250.0,
          //color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[


                    ],
                  )
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: new Stack(fit: StackFit.loose, children: <Widget>[
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        width: 140.0,
                        height: 140.0,
                        decoration: new BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          /*image: new DecorationImage(
                                    image: new ExactAssetImage(
                                        'images/profile.png'),
                                    fit: BoxFit.cover,
                                  ),*/
                        ),
                        child: Icon(Icons.person, size: 120,),

                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 90.0, right: 100.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 25.0,
                            child: new IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                              onPressed: (){},
                            ),
                          )
                        ],
                      )),
                ]),
              )
            ],
          ),
        ),
        new Container(
          //color: Color(0xffFFFFFF),
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Parsonal Information',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _status ? _getEditIcon() : new Container(),
                          ],
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child: new TextField(
                            decoration: const InputDecoration(
                              hintText: "Enter Your Name",
                            ),
                            enabled: !_status,
                            autofocus: !_status,

                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Email ID',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child: new TextField(
                            decoration: const InputDecoration(
                                hintText: "Enter Email ID"),
                            enabled: !_status,
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Mobile',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child: new TextField(
                            decoration: const InputDecoration(
                                hintText: "Enter Mobile Number"),
                            enabled: !_status,
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Address',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child: new TextField(
                            decoration: const InputDecoration(
                                hintText: "Ex: Av. Kasapa, N. 2305, Q. Gambela II "),
                            enabled: !_status,
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: new Text(
                              'Pin Code',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Container(
                            child: new Text(
                              'Pin Code',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          flex: 2,
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: new TextField(
                              decoration: const InputDecoration(
                                  hintText: "Enter Pin Code"),
                              enabled: !_status,
                            ),
                          ),
                          flex: 2,
                        ),
                        Flexible(
                          child: new TextField(
                            decoration: const InputDecoration(
                                hintText: "Enter State"),
                            enabled: !_status,
                          ),
                          flex: 2,
                        ),
                      ],
                    )),


                !_status ? _getActionButtons() : new Container(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget loginScreen(bool _status){
    return Column(
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height*0.10,),
        Container(
          height: 250.0,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Center(
                  child: new Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: new BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      /*image: new DecorationImage(
                                image: new ExactAssetImage(
                                    'images/profile.png'),
                                fit: BoxFit.cover,
                              ),*/
                    ),
                    child: FlutterLogo(textColor: Theme.of(context).primaryColorLight,)

                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Welcome to Exploress",
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor),
                      ),
                      Text("Sign in to continue"),

                    ],
                  )
              ),
            ],
          ),
        ),
        Container(
          //color: Color(0xffFFFFFF),
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )
                ),

                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child: new TextField(
                            decoration: const InputDecoration(hintText: "Enter Your Mail"),
                            enabled: !_status,
                          ),
                        ),
                      ],
                    )
                ),

                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Pin Code',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )
                ),

                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child: new TextField(
                            decoration: const InputDecoration(hintText: "Enter Your Pin Code"),
                            enabled: !_status,
                          ),
                        ),
                      ],
                    )
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 32.0,),
                  child: Container(
                    height: 200,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Container(
                              width: 200,
                                child: ProgressButton(), /*new RaisedButton(
                                  child: new Text("Login"),
                                  textColor: Colors.white,
                                  color: Colors.green,
                                  onPressed: () {
                                    setState(() {
                                      //_status = true;
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                    });
                                  },
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(20.0)),
                                )*/
                            ),
                          ),
                          SizedBox(height: 8.0,),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Container(
                                child: InkWell(
                                  child: new Text("Sign in for account",
                                    style: TextStyle(color: Theme.of(context).primaryColorLight),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      //_status = true;
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                    });
                                  },
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )

                //!_status ? _getActionButtons() : new Container(),
              ],
            ),
          ),
        )
      ],
    );
  }




  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}



*/

