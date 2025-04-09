import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e__commerce/Features/Home/data/models/ProductModel.dart';
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


  Future <void> getData() async {

    
    emit(GetDataLoading());
    try {
     Response response = await _apiServices.getData('products_table?select=*,favorite_products(*),purchase_table(*)');
        for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }

      emit(GetDataSuccess());
    } catch (e) {
      emit(GetDataError());
    }
  }
}
