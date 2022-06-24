import 'dart:convert';

import 'package:dekoki/data/model/detail.dart' as detail;
import 'package:dekoki/data/model/list.dart' as list;
import 'package:dekoki/data/model/review.dart';
import 'package:dekoki/data/model/search.dart' as search;
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _listUrl = 'list';
  static const String _detailUrl = 'detail/';
  static const String _searchUrl = 'search?q=';
  static const String _reviewUrl = 'review';
  static const String imgUrl = '${_baseUrl}images/medium/';

  Future<list.RestaurantList> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + _listUrl));
    if (response.statusCode == 200) {
      return list.RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list');
    }
  }

  Future<detail.RestaurantDetail> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detailUrl + id));
    if (response.statusCode == 200) {
      return detail.RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail');
    }
  }

  Future<search.RestaurantSearch> restaurantSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _searchUrl + query));
    if (response.statusCode == 200) {
      return search.RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search');
    }
  }

  Future<RestaurantReview> restaurantReview(CustomerReview review) async {
    var _review = jsonEncode(review.toJson());
    final response = await http.post(
      Uri.parse(_baseUrl + _reviewUrl),
      body: _review,
      headers: <String, String> {
        "Content-Type": "application/json",
      },
    );
    return RestaurantReview.fromJson(json.decode(response.body));
  }
}
