
part of 'signup_and_login.dart';


class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {

        if (state.status.isSubmissionFailure) {
          FocusScope.of(context).requestFocus(new FocusNode());
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('Authentication Failure'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                    Text("Sign in to continue"),

                  ],
                )
            ),

            const SizedBox(height: 16.0),

            Padding(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 2.0),
              child: _EmailInput(),
            ),


            const SizedBox(height: 8.0),

            Padding(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 2.0),
              child: _PasswordInput(),
            ),

            //_PasswordInput(),
            Expanded(
              child: Column(children: [
                Spacer(),
                _LoginButton(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  //color: Colors.green,
                  //width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 1, width: 70, color: Colors.grey,),
                      SizedBox(width: 4.0,),
                      Text("OR"),
                      SizedBox(width: 4.0,),

                      Container(height: 1, width: 70, color: Colors.grey,),
                    ],
                  ),
                ),
                _GoogleLoginButton(text: "Login with Google",),
                _FacebookLoginButton(text: "Login with Facebook",),
                Spacer(flex: 2,),

                _GoToSignUpPageTextButton(),
                _ContinueWithOutButton(),

              ],),
            ),

          ],
        ),
      ),
    );
  }
}