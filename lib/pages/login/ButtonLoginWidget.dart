
part of 'signup_and_login.dart';

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => BlocProvider.of<LoginCubit>(context).emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(FontAwesomeIcons.userAlt),
            labelText: 'Enter your mail address',
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {



    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              BlocProvider.of<LoginCubit>(context).passwordChanged(password),
          obscureText: !showPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(FontAwesomeIcons.lock),
            suffixIcon: IconButton(
              icon: Icon(showPassword? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye),
              onPressed: (){
                setState(() {
                  showPassword = !showPassword;
                });

              },
            ),
            labelText: 'Enter your password',
            helperText: '',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}



class _LoginButton extends StatelessWidget {
  final String text;
  _LoginButton({this.text = 'Log In'});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width *0.75;
    final theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
              width: width,
              child: RaisedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: Container(
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(FontAwesomeIcons.userCircle, color: Colors.white,),
                      Spacer(),
                      Text(text, style: TextStyle(color: Colors.white),),
                      Spacer(),
                      Icon(FontAwesomeIcons.userCircle, color: Colors.transparent,),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: theme.primaryColor,
                onPressed: state.status.isValidated
                ? () => context.read<LoginCubit>().logInWithCredentials()
                : null,
        ),
            );
        //ProgressButton(child: const Text('LOGIN'),);

      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  final String text;
  _GoogleLoginButton({this.text = "Sign in with Google"});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width *0.75;
    final theme = Theme.of(context);

    Widget googleOutlineButton = OutlinedButton(
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
      //BlocProvider.of<LoginCubit>(context).logInWithGoogle(),
      style: OutlinedButton.styleFrom(
        primary: theme.accentColor,
        textStyle: TextStyle(
          fontWeight: FontWeight.w700,
          color: theme.accentColor,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        side: BorderSide(
          color: theme.accentColor,
        ),
      ),

      child:  Container(
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(FontAwesomeIcons.google),
            Spacer(),
            Text(text),
            Spacer(),
            Icon(FontAwesomeIcons.google, color: Colors.transparent,),

          ],
        ),
      ),

    );

    return Container(width: width, child: googleOutlineButton);
  }
}

class _FacebookLoginButton extends StatelessWidget {
  final String text;
  _FacebookLoginButton({this.text= "Sign in with Facebook"});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width *0.75;
    final theme = Theme.of(context);


    Widget facebookOutlineButton = OutlineButton(
      key: const Key('loginForm_facebookLogin_outlineButton'),
      color: theme.accentColor,
      textColor: theme.accentColor,
      highlightedBorderColor: theme.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      borderSide: BorderSide(
        color: theme.accentColor,
      ),
      //icon: Icon(FontAwesomeIcons.facebookF),
      //label: Text("Sign in with Facebook"),
      child: Container(
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(FontAwesomeIcons.facebookF),
            Spacer(),
            Text(text),
            Spacer(),
            Icon(FontAwesomeIcons.facebookF, color: Colors.transparent,),

          ],
        ),
      ),
      onPressed: () {} //=> context.bloc<LoginCubit>().logInWithFacebook(),
    );

    return Container(width: width, child: facebookOutlineButton);
  }
}

class _GoToSignUpPageTextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var textSignUp = RichText(
      text: TextSpan(
        text: "Don't have an account?",
        style: TextStyle(color: Colors.grey),
        children: [
          TextSpan(
            text: "Create an account",
            style: TextStyle(color: theme.primaryColor),
          ),
        ],
      ) ,
    );
    Widget flatButton = TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      child: textSignUp,
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
    );

    return  flatButton;
  }
}


class _ContinueWithOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text1 = "SKIP";
    final text2 = "CONTINUE WITHOUT AN ACCOUNT";

    return TextButton(
      key: const Key('withoutForm_createAccount_flatButton'),
      child: Text(
        text2,
        style: TextStyle(color: theme.primaryColor),
      ),
      onPressed: () => Navigator.of(context)
          .pushAndRemoveUntil<void>(HomePage.route(),(route) => false),
    );
  }
}


class _EmailSignInInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => BlocProvider.of<SignUpCubit>(context).emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(FontAwesomeIcons.userAlt),
            labelText: 'email',
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordSignInInput extends StatefulWidget {
  @override
  __PasswordSignInInputState createState() => __PasswordSignInInputState();
}


class __PasswordSignInInputState extends State<_PasswordSignInInput> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              BlocProvider.of<SignUpCubit>(context).passwordChanged(password),
          obscureText: !showPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(FontAwesomeIcons.lock),
            suffixIcon: IconButton(
              icon: Icon(showPassword? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye),
              onPressed: (){
                setState(() {
                  showPassword = !showPassword;
                });

              },
            ),
            labelText: 'password',
            helperText: '',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _SignUpSignInButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width *0.75;

    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                width: width,
                child: RaisedButton(
                  key: const Key('signUpForm_continue_raisedButton'),
                  child: Container(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(FontAwesomeIcons.userCircle, color: Colors.white,),
                        Spacer(),
                        Text('Register', style: TextStyle(color: Colors.white),),
                        Spacer(),
                        Icon(FontAwesomeIcons.userCircle, color: Colors.transparent,),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: theme.primaryColor,
                  onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
          ),
        );
      },
    );
  }
}
