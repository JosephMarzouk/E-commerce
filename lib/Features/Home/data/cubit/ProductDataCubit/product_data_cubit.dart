import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e__commerce/Features/Home/data/models/FavoriteProductModel.dart';
import 'package:e__commerce/Features/Home/data/models/ProductModel.dart';
import 'package:e__commerce/Features/Home/data/models/PurchasedProductModel.dart';
import 'package:e__commerce/core/API_class.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_data_state.dart';

class ProductDataCubit extends Cubit<ProductDataState> {
  ProductDataCubit() : super(ProductDataInitial());
  final ApiService _apiServices = ApiService();
  final String userId = Supabase.instance.client.auth.currentUser!.id;

  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];
  List<ProductModel> categoryProducts = [];

  Future<void> getData({String? query, String? category}) async {
    emit(GetDataLoading());
    try {
      Response response = await _apiServices.getData(
          'https://asbxvyaxvraxpevngyjy.supabase.co/rest/v1/products_table?select=*,favorite_products(*)');
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
      getFavoriteProducts();
      search(query);
      getProductsByCategory(category);
      getUserOrdersProducts();

      emit(GetDataSuccess());

      emit(GetDataSuccess());
    } catch (e) {
      emit(GetDataError());
    }
  }

  void search(String? query) {
    if (query != null) {
      for (var product in products) {
        if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(product);
        }
      }
    }
  }

  void getProductsByCategory(String? category) {
    if (category != null) {
      for (var product in products) {
        // "sports"
        if (product.category!.trim().toLowerCase() ==
            category.trim().toLowerCase()) {
          categoryProducts.add(product);
        }
      }
    }
  }

  List<ProductModel> userOrders = [];
  void getUserOrdersProducts() {
    for (ProductModel product in products) {
      if (product.purchaseTable != null && product.purchaseTable!.isNotEmpty) {
        for (PurchaseTable userOrder in product.purchaseTable!) {
          if (userOrder.forUser == userId) {
            userOrders.add(product);
          }
        }
      }
    }
  }

  Map<String, bool> favoriteProducts = {};
  // "product_id" : true
  // add To Favorite
  Future<void> addToFavorite(String productId) async {
    // emit(AddToFavoriteLoading());
    try {
      await _apiServices.postData("favorite_products", {
        "is_favorite": true,
        "for_user": userId,
        "for_product": productId,
      });

      await getData();
      favoriteProducts.addAll({
        productId: true,
      });

      emit(AddToFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddToFavoriteError());
    }
  }

  bool checkIsFavorite(String productId) {
    return favoriteProducts.containsKey(productId);
  }
  // remove from favorite

  Future<void> removeFavorite(String productId) async {
    // emit(RemoveFromFavoriteLoading());
    try {
      await _apiServices.deleteData(
          "favorite_products?for_user=eq.$userId&for_product=eq.$productId");
      await getData();
      favoriteProducts.removeWhere((key, value) => key == productId);
      emit(RemoveFromFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(RemoveFromFavoriteError());
    }
  }

  // get favorite products
  List<ProductModel> favoriteProductList = [];
  void getFavoriteProducts() async{
    
    for (ProductModel product in products) {
      if (product.favoriteProducts != null &&
          product.favoriteProducts!.isNotEmpty) {
        for (FavoriteProduct favoriteProduct in product.favoriteProducts!) {
          if (favoriteProduct.forUser == userId) {
            favoriteProductList.add(product);
            favoriteProducts.addAll({product.productId!: true});
          }
        }
      }
    }
  }

  Future<void> buyProduct({required String productId}) async {
    emit(BuyProductLoading());
    try {
      await _apiServices.postData("purchase_table", {
        "for_user": userId,
        "is_bought": true,
        "for_product": productId,
      });
      emit(BuyProductDone());
    } catch (e) {
      log(e.toString());
      emit(BuyProductError());
    }
  }
}
