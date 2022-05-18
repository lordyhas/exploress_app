import 'dart:async';

import 'package:flutter/material.dart';

class PageViewSlide extends StatefulWidget {
  @override
  _PageViewSlideState createState() => _PageViewSlideState();
}

class _PageViewSlideState extends State<PageViewSlide> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class PageSelectorSlide extends StatelessWidget {
  final List<Widget> children;
  final double? padding;
  final Color? btnNextColor;
  final Color? btnBackColor;
  final Text? btnNextText;
  final Text? btnBackText;
  final Color? tabColor;
  final Color? tabSelectedColor;
  final bool? isAutoSlide;

  PageSelectorSlide({
      required this.children,
      this.padding,
      this.btnNextColor,
      this.btnBackColor,
      this.btnNextText,
      this.btnBackText,
      this.tabColor,
      this.tabSelectedColor,
      this.isAutoSlide
  }) : assert(children != null, "children widget can't be null"); //assert();

  static const kIcons = <Icon>[
    Icon(Icons.event, size: 150,),
    Icon(Icons.home),
    Icon(Icons.android),
    Icon(Icons.alarm),
    Icon(Icons.face),
    Icon(Icons.language),
  ];

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: children.length,
      // Use a Builder here, otherwise `DefaultTabController.of(context)` below
      // returns null.
      child: Builder(
        builder: (BuildContext context) => Padding(
          padding: EdgeInsets.all(padding ??8.0),
          child: Column(
            children: <Widget>[
              TabPageSelector(
                //color: tabColor ?? Colors.blue,
                selectedColor: tabSelectedColor ?? Colors.blueAccent,
              ),
              Expanded(
                child: TabBarView(children: children),
              ),
              Row(
                children: [
                  OutlineButton(
                    textColor: btnBackColor ?? Colors.black,
                    borderSide: BorderSide(width: 2.0, color: btnBackColor ?? Colors.black),
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      int i = 0;
                      final TabController controller = DefaultTabController.of(context)!;
                      if (!controller.indexIsChanging) {
                        controller.animateTo(children.length - 1);
                      }
                      Timer.periodic(Duration(seconds: 3), (timer) {
                        print("Slide Move img to : $i");
                        if (!controller.indexIsChanging) {
                          controller.animateTo(i);
                          i++;
                        }
                        if(i == children.length) i=0;
                        //print(DateTime.now());

                      });
                    },
                    child: btnBackText,
                  ),

                  OutlineButton(
                      textColor: btnNextColor ?? Colors.black,
                      borderSide: BorderSide(width: 2.0, color: btnNextColor ?? Colors.black),
                      padding: EdgeInsets.all(8.0),
                      onPressed: (){},
                    child: btnNextText,
                  )

                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
