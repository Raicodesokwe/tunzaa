import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/product_model.dart';

class ApiProvider with ChangeNotifier {
  String productUrl = 'https://fakestoreapi.com/products';
  Dio dio = Dio();
  List<Product> productList = [];

  int totalAmount = 0;

  Future<List<Product>> getProducts() async {
    try {
      final result = await dio.get(productUrl);
      final List products = result.data;
      productList = products.map((json) => Product.fromJson(json)).toList();
      print('The result is $result');
      print('The result is ${result.statusCode}');
      if (result.statusCode != 200) throw Exception();
    } on DioError catch (e) {
      // TODO
      print('The error is $e');
      throw Exception();
    }
    return productList;
  }

  void addToCart(int index) {
    productList[index].addToCart = true;

    notifyListeners();
  }

  void reduceAmount(int index) {
    productList[index].amount--;
    notifyListeners();
  }

  void addAmount(int index) {
    productList[index].amount++;
    notifyListeners();
  }

  String _searchString = "";
  UnmodifiableListView<Product> get prods => _searchString.isEmpty
      ? UnmodifiableListView(productList)
      : UnmodifiableListView(productList.where(
          (element) => element.title.toLowerCase().contains(_searchString)));
  void changeSearchString(String searchString) {
    _searchString = searchString;
    print(_searchString);
    notifyListeners();
  }

  Comparator<Product> priceComparatorLowest =
      (a, b) => a.price.compareTo(b.price);
  Comparator<Product> ratingComparatorLowest =
      (a, b) => a.rating.rate.compareTo(b.rating.rate);
  Comparator<Product> ratingComparatorHighest =
      (b, a) => a.rating.rate.compareTo(b.rating.rate);
  Comparator<Product> priceComparatorHighest =
      (b, a) => a.price.compareTo(b.price);

  void sortPriceLowest() {
    productList.sort(priceComparatorLowest);
    notifyListeners();
  }

  void sortRatingLowest() {
    productList.sort(ratingComparatorLowest);
    notifyListeners();
  }

  void sortRatingHighest() {
    productList.sort(ratingComparatorHighest);
    notifyListeners();
  }

  void sortPriceHighest() {
    productList.sort(priceComparatorHighest);
    notifyListeners();
  }
}
