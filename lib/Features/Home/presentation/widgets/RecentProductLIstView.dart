
 import 'dart:developer';

import 'package:e__commerce/Features/Home/data/cubit/ProductDataCubit/product_data_cubit.dart';
import 'package:e__commerce/Features/Home/data/models/ProductModel.dart';
import 'package:e__commerce/Features/Home/presentation/widgets/ProductCard.dart';
import 'package:e__commerce/Shared/Functions/ShowMessageFunction.dart';
import 'package:e__commerce/core/CustomCircleProgIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 class RecentProductListView extends StatelessWidget {
  const RecentProductListView({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.query,
    this.category,
    this.isFavoriteView = false,
    this.isMyOrdersView = false,
  });

  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? query;
  final String? category;
  final bool isFavoriteView;
  final bool isMyOrdersView;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDataCubit()..getData(query: query, category: category,),
      child: BlocConsumer<ProductDataCubit, ProductDataState>(
        listener: (context, state) {
          if (state is BuyProductDone) {
            showMsg(context, "Payment Success , check your orders");
          }
        },
        builder: (context, state) {
          ProductDataCubit homeCubit = context.read<ProductDataCubit>();
          List<ProductModel> products = query != null
              ? context.read<ProductDataCubit>().searchResults
              :
              // query == null
              category != null
                  ? context.read<ProductDataCubit>().categoryProducts
                  : isFavoriteView
                      ? homeCubit.favoriteProductList
                      : isMyOrdersView
                          ? homeCubit.userOrders
                          :
                          // query == null & category == null
                          context.read<ProductDataCubit>().products;
          return state is GetDataLoading
              ? const CustomCircleProgIndicator()
              : ListView.builder(
                  shrinkWrap: shrinkWrap ?? true,
                  physics: physics ?? const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      onPaymentSuccess: () async{
                      await  homeCubit.buyProduct(
                            productId: products[index].productId!);
                            log("Payment Success");
                           // showMenu(context: context,)
                      },
                      isFavorite:
                          homeCubit.checkIsFavorite(products[index].productId!),
                      onTap: () {
                        bool isFavorite = homeCubit
                            .checkIsFavorite(products[index].productId!);
                        isFavorite
                            ? homeCubit
                                .removeFavorite(products[index].productId!)
                            : homeCubit
                                .addToFavorite(products[index].productId!);
                      },
                      product: products[index],
                    );
                  });
        },
      ),
    );
  }
}