import 'package:dekoki/common/style.dart';
import 'package:dekoki/data/api/api_service.dart';
import 'package:dekoki/data/model/list.dart';
import 'package:dekoki/page/restaurant_detail.dart';
import 'package:dekoki/provider/detail_provider.dart';
import 'package:dekoki/utils/result_state.dart';
import 'package:dekoki/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant listRestaurant;

  const RestaurantDetailPage({Key? key, required this.listRestaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantDetailProvider provider;

    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(apiService: ApiService(), id: listRestaurant.id),
      child: SafeArea(
        child: CustomScaffold(
          body: SingleChildScrollView(
            child: Consumer<RestaurantDetailProvider>(
              builder: (context, state, _) {
                provider = state;
                if (state.state == ResultState.loading) {
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
                } else if (state.state == ResultState.hasData) {
                  final detailRestaurant = state.result;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RestaurantDetail(
                        detailRestaurants: detailRestaurant,
                        providers: provider,
                        listRestaurants: listRestaurant,
                      ),
                    ],
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2.7,
                        ),
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
                            provider.restaurantDetail(listRestaurant.id);
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
              },
            ),
          ),
        ),
      ),
    );
  }
}
