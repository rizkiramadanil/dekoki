import 'dart:async';

import 'package:dekoki/data/api/api_service.dart';
import 'package:dekoki/data/model/review.dart';
import 'package:dekoki/utils/result_state.dart';
import 'package:flutter/material.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    restaurantDetail(id);
  }

  String _message = '';
  late dynamic _restaurantResult;
  late ResultState _state;

  String get message => _message;
  dynamic get result => _restaurantResult;
  ResultState get state => _state;

  Future<dynamic> restaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.restaurantDetail(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantResult = restaurantDetail.restaurant;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

  Future<dynamic> restaurantReview(CustomerReview review) async {
    try {
      final response = await apiService.restaurantReview(review);
      if (!response.error) restaurantDetail(review.id!);
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error: $e";
    }
  }
}
