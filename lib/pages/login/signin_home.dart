
part of 'signup_and_login.dart';


class LoginHome extends StatefulWidget {
  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageView(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                    child: Placeholder(),
                  ),Container(
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                    child: Placeholder(),
                  ),Container(
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                    child: Placeholder(),
                  ),Container(
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                    child: Placeholder(),
                  ),Container(
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                    child: Placeholder(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
