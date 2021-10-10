
import 'package:flutter/material.dart';

class TitledBottomBarWidget extends StatefulWidget {
  @override
  State createState() => _TitledBottomBarWidgetState();
}

class _TitledBottomBarWidgetState extends State<TitledBottomBarWidget> {
  final List<ItemNavigationBar> items = [
    ItemNavigationBar('Home', Icons.home),
    ItemNavigationBar('Search', Icons.search),
    ItemNavigationBar('Person', Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return TitledBottomNavigationBar(
      items: items,
    );
  }
}

typedef OnTap = void Function();

class TitledBottomNavigationBar extends StatefulWidget {
  final Color elevationShadowColor, textColor, iconColor;
  final Color? backgroundColor;
  final double? textSize;
  final double? iconSize;
  final List<ItemNavigationBar>? items;
  final Function(int index)? onTap;
  final int currentIndex;

  const TitledBottomNavigationBar({
    Key? key,
    this.items,
    this.onTap,
    this.currentIndex = 0,
    this.backgroundColor,
    this.elevationShadowColor = Colors.black12,
    this.textColor = Colors.black,
    this.iconColor = Colors.white,
    this.textSize,
    this.iconSize,
  }) : super(key: key);

  @override
  _TitledBottomNavigationBarState createState() => _TitledBottomNavigationBarState();
}

class _TitledBottomNavigationBarState extends State<TitledBottomNavigationBar>
    with SingleTickerProviderStateMixin {

  List<ItemNavigationBar> get items => widget.items!;
  int selectedIndex = 0;
  static const double BAR_HEIGHT = 60;
  static const double INDICATOR_HEIGHT = 2;
  static const double INDICATOR_WIDTH = 10;
  double width = 0;
  double indicatorAlignX = 0;

  Duration duration = Duration(milliseconds: 270);

  @override
  void initState() {
    selectedIndex = widget.currentIndex;
    _select(selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      height: BAR_HEIGHT,
      width: width,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: widget.elevationShadowColor,
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
//        overflow: Overflow.visible,// Debug use
        children: <Widget>[
          Positioned(
            top: INDICATOR_HEIGHT,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: items.map((item) {
                var index = items.indexOf(item);
                return GestureDetector(
                  onTap: () {
                    widget.onTap!(index);
                    setState(() {
                      _select(index);

                    });
                  },
                  child: _buildItemWidget(item, index == selectedIndex),
                );
              }).toList(),
            ),
          ),
          Positioned(
            top: 0,
            width: width,
            child: AnimatedAlign(
              alignment: Alignment(indicatorAlignX, 0),
              curve: Curves.linear,
              duration: duration,
              child: Container(
                color: widget.iconColor,
                width: width / items.length,
                height: INDICATOR_HEIGHT,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _select(int index) {
    selectedIndex = index;
    indicatorAlignX = -1 + (2 / (items.length - 1) * index);
  }

  Widget _buildItemWidget(ItemNavigationBar item, bool isSelected) {
    return Container(
      color: widget.backgroundColor ?? Theme.of(context).primaryColor,
      height: BAR_HEIGHT,
      width: width / items.length,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          AnimatedOpacity(
            opacity: isSelected ? 0.0 : 1.0,
            duration: duration,
            curve: Curves.linear,
            child: Text(item.title,
              style: TextStyle(
                color: widget.textColor,
                fontSize: widget.textSize??null,
              ),
            ),
          ),
          AnimatedAlign(
            duration: duration,
            alignment: isSelected ? Alignment.center : Alignment(0, 2.6),
            child: Icon(item.icon, color: widget.iconColor, size: widget.iconSize ?? null,),
          ),
        ],
      ),
    );
  }
}

class ItemNavigationBar {
  final String title;
  final IconData icon;

  ItemNavigationBar(this.title, this.icon);
}