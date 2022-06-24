import 'package:dekoki/common/style.dart';
import 'package:dekoki/data/api/api_service.dart';
import 'package:dekoki/data/model/list.dart';
import 'package:dekoki/provider/list_provider.dart';
import 'package:dekoki/utils/result_state.dart';
import 'package:dekoki/widget/restaurant_search_item.dart';
import 'package:dekoki/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  late RestaurantListProvider _provider;
  late final FocusNode _focusNode;
  List<Restaurant> _restaurant = [];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: Column(
          children: [_buildSearchBar(), _buildList()],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Consumer<RestaurantListProvider>(
        builder: (context, state, _) {
          _provider = state;
          if(state.state == ResultState.loading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                  ),
                  const CircularProgressIndicator(
                    color: ColorStyles.secondaryColor,
                  ),
                ],
              ),
            );
          } else if (state.state == ResultState.hasData) {
            _restaurant = state.result;
            return _buildItem(_restaurant);
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
            _provider.restaurantList();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3.3,
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
                      _provider.restaurantList();
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
    );
  }

  Widget _buildSearchBar() {
    return SearchBar(
      focusNode: _focusNode,
      onChanged: searchData,
    );
  }

  Widget _buildItem(results) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => RestaurantSearchItem(
          restaurant: results[index],
        ),
        itemCount: results.length,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _provider = RestaurantListProvider(apiService: ApiService(), id: '');
    init();
  }

  Future init() async {
    final restaurants = await _provider.restaurantList();

    if (!mounted) {
      return;
    } else {
      setState(() => _restaurant = restaurants);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void searchData(String _query) async {
    final result = await _provider.restaurantSearch(_query);

    if (!mounted) {
      return;
    } else {
      setState(() {
        if (result == String) _restaurant = result;
      });
    }
  }
}
