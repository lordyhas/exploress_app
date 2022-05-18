
part of 'signup_and_login.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      //appBar: AppBar(title: const Text('Sign Up')),
      //resizeToAvoidBottomPadding: false ,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(
            context.read<AuthenticationRepository>(),
          ),
          child: SignUpForm(),
        ),
      ),
    );
  }
}
