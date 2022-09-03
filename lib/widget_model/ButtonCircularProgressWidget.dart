import 'dart:async';

import 'package:flutter/material.dart';

enum ProgressStep{zero, one, two}

class ProgressButton extends StatefulWidget {

  final Color? color;
  final Color? shadowColor;
  final Function? onPressed;
  final bool? isProgress;
  final Widget? child;
  final double? radius;
  final double? elevation;

  ProgressButton({
    Key? key,
    this.color,
    this.shadowColor,
    this.onPressed,
    this.isProgress,
    this.child,
    this.radius, this.elevation
  }): super(key: key);



  @override
  _ProgressButtonState createState() => _ProgressButtonState();


}

class _ProgressButtonState extends State<ProgressButton> with TickerProviderStateMixin {
  int _state = 0;
  ProgressStep _progressStep = ProgressStep.zero;
  Animation? _animation;
  AnimationController? _controller;
  GlobalKey _globalKey = GlobalKey();
  double _width = double.maxFinite;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    /*if(widget.isProgress)
      setState(() {
        if (_state == 0) {
          animateButton();
        }
      });*/

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Align(
          alignment: Alignment.center,
          child: PhysicalModel(
            elevation: widget.elevation ?? 8,
            shadowColor: Theme.of(context).primaryColor.withOpacity(0.8),
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(widget.radius ??25),
            child: Container(
              key: _globalKey,
              height: 48,
              width: _width,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  animationDuration: Duration(milliseconds: 1000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.radius ?? 25),
                  ),
                  padding: EdgeInsets.all(0),
                  elevation: 4,
                ) ,

                child: setUpButtonChild(),
                onPressed: () {
                  widget.onPressed!();
                  setState(() {
                    if (_state == 0) {
                      animateButton();
                    }
                  });
                },


              ),
            ),
          ),
        ),
      ),

    );
  }

  setUpButtonChild() {
    if (_state == 0) {
      return widget.child ?? Text(
        "Click Here",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      );
    } else if (_state == 1) {
      return SizedBox(
        height: 36,
        width: 36,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void animateButton() {
    double initialWidth = _globalKey.currentContext!.size!.width;

    _controller = AnimationController(
        duration: Duration(milliseconds: 300), vsync: this
    );

    _animation = Tween(begin: 0.0, end: 1).animate(_controller!)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48) * _animation!.value);
        });
      });
    _controller!.forward();

    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
      });
    });
  }
}
