import 'package:dekoki/common/style.dart';
import 'package:dekoki/page/favorite_page.dart';
import 'package:dekoki/page/home_page.dart';
import 'package:dekoki/page/setting_page.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

class BotNavBar extends StatefulWidget {
  const BotNavBar({Key? key}) : super(key: key);

  @override
  State<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int currentPage = 1;
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _getPage(currentPage),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
              iconData: Icons.favorite,
              title: "Favorite",
              onclick: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const HomePage()))
          ),
          TabData(
              iconData: Icons.home,
              title: "Home",
              onclick: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const HomePage()))
          ),
          TabData(
              iconData: Icons.settings,
              title: "Setting",
              onclick: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const HomePage()))
          ),
        ],
        initialSelection: 1,
        key: bottomNavigationKey,
        activeIconColor: ColorStyles.primaryColor,
        inactiveIconColor: ColorStyles.secondaryColor,
        circleColor: ColorStyles.secondaryColor,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return const FavoritePage();
      case 1:
        return const HomePage();
      case 2:
        return const SettingPage();
    }
  }
}
