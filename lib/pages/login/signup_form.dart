
part of 'signup_and_login.dart';



class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 32.0,),
            Padding(
              padding: EdgeInsets.all(8.0).copyWith(),
              child: Image.asset(
                'assets/img/exploress_icon.png',
                height: 120,
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
                    Text("create an account to continue"),

                  ],
                )
            ),
            /*Padding(
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
            ),*/
            Padding(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 2.0),
              child: _EmailSignInInput(),
            ),
            //_EmailSignInInput(),
            const SizedBox(height: 8.0),
            /*Padding(
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
                          'Password',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )
            ),*/

            Padding(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 2.0),
              child: _PasswordSignInInput(),
            ),
            //_PasswordSignInInput(),
            const SizedBox(height: 8.0),

            Expanded(
              child: Column(children: [
                Spacer(),
                //_LoginButton(),
                _SignUpSignInButton(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  //color: Colors.green,
                  //width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 1, width: 70, color: Colors.grey,),
                      SizedBox(width: 4.0,),
                      Text("Or"),
                      SizedBox(width: 4.0,),

                      Container(height: 1, width: 70, color: Colors.grey,),
                    ],
                  ),
                ),
                _GoogleLoginButton(text: "Register with Google",),
                _FacebookLoginButton(text: "Register with Facebook",),
                Spacer(flex: 2,),
              ],),
            ),
          ],
        ),
      ),
    );
  }
}
