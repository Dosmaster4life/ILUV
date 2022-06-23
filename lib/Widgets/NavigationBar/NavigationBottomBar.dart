

import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:iluv/screens/Screen1.dart';
import 'package:iluv/screens/Screen2.dart';
import 'package:iluv/screens/Screen3.dart';

class NavigationBottomBar extends StatefulWidget {
  const NavigationBottomBar({Key? key, required this.hideB}) : super(key: key);
  final bool hideB;
  @override
  _NavigationBottomBarState createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  bool hideNavigationBar = false;
  final PersistentTabController _navigationController =
  PersistentTabController(initialIndex: 0);
  List<Widget> screenList = <Widget>[
    // Current Home Screens
    const Screen1(),
    const Screen2(),
    const Screen3()
  ];

  void hideNavigationBottomBar() {
    hideNavigationBar = true;
    setState(() {});
  }

  List<PersistentBottomNavBarItem> _navigationItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeGreen,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.airplane),
        title: ("Forum"),
        activeColorPrimary: CupertinoColors.activeGreen,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.alarm_fill),
        title: ("Post"),
        activeColorPrimary: CupertinoColors.activeGreen,
        inactiveColorPrimary: CupertinoColors.black,
      ),
    ];
  }

  List<Widget> _screenList() {
    return [const Screen1(), const Screen2(), const Screen3()];
  }

  PersistentTabView BottomNavigationBarBuilder(context) {
      return PersistentTabView(
        context,
        hideNavigationBar: hideNavigationBar,
        controller: _navigationController,
        screens: _screenList(),
        items: _navigationItems(),
        navBarStyle: NavBarStyle.style6,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: false,
          curve: Curves.ease,
          duration: Duration(milliseconds: 300),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBarBuilder(context);
  }

}