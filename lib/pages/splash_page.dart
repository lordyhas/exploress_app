
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 64),
            child: Container(
              height: 200,
              child:Image.asset("assets/img/exploress_icon.png",
                color: Theme.of(context).primaryColor.withOpacity(0.85) ,),
            ),
          ),
          //Text("XXXXXX", style: TextStyle(color: Colors.black, fontSize: 42),),
          Expanded(
            child: Column(
              children: [
                Spacer(),
                Center(
                    child: CircularProgressIndicator()
                ),
                Spacer(),
                SizedBox(height: 2.0,),
                Spacer(),
                SizedBox(height: 2.0,),
                Spacer(),
              ],
            ),
          ),
        ],
      )
    );
  }
}

/* Image.asset(
            'assets/img/exploress_icon.png',
            key: const Key('splash_icon_image'),
            width: 150,
        ),
      ) */
