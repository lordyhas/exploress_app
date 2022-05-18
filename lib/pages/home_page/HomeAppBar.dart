part of '../home_page.dart';



class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader({
    required this.child,
  });
  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class AppBottomBarSlide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SlideContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

