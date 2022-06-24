import 'dart:async';

import 'package:dekoki/data/api/api_service.dart';
import 'package:dekoki/utils/result_state.dart';
import 'package:flutter/material.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantListProvider({required this.apiService, required this.id}) {
    restaurantList();
  }

  String _message = '';
  late dynamic _restaurantResult;
  late ResultState _state;

  String get message => _message;
  dynamic get result => _restaurantResult;
  ResultState get state => _state;

  Future<dynamic> restaurantList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await apiService.restaurantList();
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantResult = restaurantList.restaurants;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

  Future<dynamic> restaurantSearch(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantSearch = await apiService.restaurantSearch(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Result Found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurantSearch.restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
