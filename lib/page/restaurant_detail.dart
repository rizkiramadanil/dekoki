import 'package:dekoki/common/style.dart';
import 'package:dekoki/data/api/api_service.dart';
import 'package:dekoki/data/model/detail.dart' as detail;
import 'package:dekoki/data/model/list.dart' as list;
import 'package:dekoki/provider/database_provider.dart';
import 'package:dekoki/provider/detail_provider.dart';
import 'package:dekoki/widget/review_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RestaurantDetail extends StatelessWidget {
  final detail.Restaurant detailRestaurants;
  final RestaurantDetailProvider providers;
  final list.Restaurant listRestaurants;

  const RestaurantDetail({Key? key, required this.detailRestaurants, required this.providers, required this.listRestaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(detailRestaurants.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: <Widget>[
                    Hero(
                      tag: listRestaurants.pictureId,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 220,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    ApiService.imgUrl + listRestaurants.pictureId),
                              ),
                            ),
                          ),
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 165.0, right: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  isFavorited ? IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: ColorStyles.activeFavoriteColor,
                                      size: 36.0,
                                    ),
                                    onPressed: () => provider.removeFavorite(detailRestaurants.id),
                                  ) : IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: ColorStyles.inactiveFavoriteColor,
                                      size: 36.0,
                                    ),
                                    onPressed: () => provider.addFavorite(listRestaurants),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                listRestaurants.name,
                                style: GoogleFonts.roboto(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: ColorStyles.primaryTextColor,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 20,
                                    color: ColorStyles.ratingColor,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    listRestaurants.rating.toString(),
                                    style: GoogleFonts.roboto(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: ColorStyles.primaryTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(
                                Icons.place,
                                size: 15,
                                color: ColorStyles.tertiaryTextColor,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                listRestaurants.city,
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: ColorStyles.tertiaryTextColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(thickness: 1),
                          const SizedBox(height: 8),
                          Text(
                            "Deskripsi",
                            style: GoogleFonts.roboto(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: ColorStyles.primaryTextColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            listRestaurants.description,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: ColorStyles.primaryTextColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Menu Makanan",
                        style: GoogleFonts.roboto(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: ColorStyles.primaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      buildFoodItem(context),
                      const SizedBox(height: 20),
                      Text(
                        "Menu Minuman",
                        style: GoogleFonts.roboto(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: ColorStyles.primaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      buildDrinkItem(context),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Review Pelanggan",
                            style: GoogleFonts.roboto(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: ColorStyles.primaryTextColor,
                            ),
                          ),
                          ElevatedButton(
                            child: Text(
                              "Tambahkan review",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: ColorStyles.primaryColor,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: ColorStyles.secondaryColor,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ReviewDialog(provider: providers, id: detailRestaurants.id),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6),
                buildReview(context),
              ],
            );
          });
      });
  }

  Widget buildFoodItem(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: detailRestaurants.menus.foods.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child:
                    Image.asset("assets/images/foods.jpg", fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  detailRestaurants.menus.foods[index].name,
                  style: GoogleFonts.roboto(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: ColorStyles.primaryTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDrinkItem(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: detailRestaurants.menus.drinks.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child:
                    Image.asset("assets/images/drinks.jpg", fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  detailRestaurants.menus.drinks[index].name,
                  style: GoogleFonts.roboto(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: ColorStyles.primaryTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildReview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: detailRestaurants.customerReviews.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 81,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      margin: const EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  detailRestaurants.customerReviews[index].name,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorStyles.primaryTextColor,
                                  ),
                                ),
                                Text(
                                  detailRestaurants.customerReviews[index].date,
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    color: ColorStyles.primaryTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Text(
                            detailRestaurants.customerReviews[index].review,
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: ColorStyles.primaryTextColor,
                            ),
                            textAlign: TextAlign.justify,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
