import 'package:dekoki/common/style.dart';
import 'package:dekoki/data/model/list.dart';
import 'package:dekoki/page/restaurant_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantSearchItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantSearchItem({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 73,
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(0),
            child: ListTile(
              title: Text(
                restaurant.name,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorStyles.primaryTextColor,
                ),
              ),
              subtitle: Text(
                restaurant.city,
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  color: ColorStyles.primaryTextColor,
                ),
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
}
