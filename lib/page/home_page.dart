import 'package:dekoki/common/style.dart';
import 'package:dekoki/data/api/api_service.dart';
import 'package:dekoki/data/model/list.dart';
import 'package:dekoki/page/restaurant_detail_page.dart';
import 'package:dekoki/page/restaurant_search_page.dart';
import 'package:dekoki/provider/list_provider.dart';
import 'package:dekoki/utils/result_state.dart';
import 'package:dekoki/widget/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  Widget buildList(BuildContext context) {
    late RestaurantListProvider provider;

    return ChangeNotifierProvider<RestaurantListProvider>(
      create: (_) => RestaurantListProvider(apiService: ApiService(), id: ''),
      child: Consumer<RestaurantListProvider>(builder: (context, state, _) {
        provider = state;
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorStyles.secondaryColor,
            ),
          );
        } else if (state.state == ResultState.hasData) {
          final List<Restaurant> restaurant = state.result;
          return ListView.builder(
            itemCount: restaurant.length,
            itemBuilder: (context, index) {
              return buildRestaurantListItem(context, restaurant[index]);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                ),
                Text(
                  state.message,
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
        } else if (state.state == ResultState.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/img-no-connection.png",
                  width: 100,
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "No Connection!",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      color: ColorStyles.tertiaryTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Text(
                    "Please check your connection or try again later.",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      color: ColorStyles.tertiaryTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text("Retry"),
                  style: ElevatedButton.styleFrom(
                    primary: ColorStyles.secondaryColor,
                  ),
                  onPressed: () {
                    provider.restaurantList();
                  },
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
      }),
    );
  }

  Widget buildRestaurantListItem(BuildContext context, Restaurant restaurant) {
    return SizedBox(
      height: 83,
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(0),
            child: ListTile(
              contentPadding:
              const EdgeInsets.all(8),
              leading: Hero(
                tag: restaurant.pictureId,
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(ApiService.imgUrl + restaurant.pictureId),
                    ),
                  ),
                ),
              ),
              title: Text(
                restaurant.name,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorStyles.primaryTextColor,
                ),
              ),
              subtitle: Column(
                children: <Widget>[
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(
                        Icons.place,
                        size: 13,
                        color: ColorStyles.secondaryTextColor,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        restaurant.city,
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: ColorStyles.primaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: ColorStyles.ratingColor,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        restaurant.rating.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ColorStyles.ratingTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, RestaurantDetailPage.routeName, arguments: restaurant);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'dekoki',
          style: GoogleFonts.fredokaOne(
            fontSize: 30,
            color: ColorStyles.primaryColor,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 34,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const RestaurantSearchPage()));
            },
          ),
        ],
      ),
      body: buildList(context),
    );
  }

  Widget buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'dekoki',
          style: GoogleFonts.fredokaOne(
            fontSize: 30,
            color: ColorStyles.primaryColor,
          ),
        ),
        trailing: GestureDetector(
          child: const Icon(
            CupertinoIcons.search,
            size: 34,
            color: ColorStyles.primaryColor,
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const RestaurantSearchPage()));
          },
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
