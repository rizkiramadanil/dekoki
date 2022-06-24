import 'package:dekoki/common/style.dart';
import 'package:dekoki/provider/database_provider.dart';
import 'package:dekoki/utils/result_state.dart';
import 'package:dekoki/widget/platform_widget.dart';
import 'package:dekoki/widget/restaurant_favorite_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite';

  const FavoritePage({Key? key}) : super(key: key);

  Widget buildList(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                ),
                const CircularProgressIndicator(
                  color: ColorStyles.secondaryColor,
                ),
              ],
            ),
          );
        } else if (provider.state == ResultState.hasData) {
          return CustomScrollView(
            semanticChildCount: provider.favorites.length,
            slivers: [
              SliverSafeArea(
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < provider.favorites.length) {
                        return RestaurantFavoriteItem(
                          restaurant: provider.favorites[index],
                        );
                      }
                      return null;
                    }
                  ),
                ),
              ),
            ],
          );
        } else if (provider.state == ResultState.noData) {
          return Center(
            child: Text(
              provider.message,
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorStyles.tertiaryTextColor,
                decoration: TextDecoration.none,
              ),
            ),
          );
        } else if (provider.state == ResultState.error) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                ),
                Text(
                  "Error",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorStyles.tertiaryTextColor,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                ),
                Text(
                  "Error",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorStyles.tertiaryTextColor,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: GoogleFonts.roboto(
            fontSize: 26,
            color: ColorStyles.primaryColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: buildList(context),
    );
  }

  Widget buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Favorite',
          style: GoogleFonts.roboto(
            fontSize: 26,
            color: ColorStyles.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorStyles.secondaryColor,
        transitionBetweenRoutes: false,
      ),
      child: buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: buildAndroid,
      iosBuilder: buildIos,
    );
  }
}
