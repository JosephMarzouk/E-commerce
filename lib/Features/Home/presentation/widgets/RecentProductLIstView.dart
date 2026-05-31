import 'dart:developer';

import 'package:e__commerce/Features/Home/data/cubit/ProductDataCubit/product_data_cubit.dart';
import 'package:e__commerce/Features/Home/data/models/ProductModel.dart';
import 'package:e__commerce/Features/Home/presentation/widgets/ProductCard.dart';
import 'package:e__commerce/Shared/Functions/ShowMessageFunction.dart';
import 'package:e__commerce/core/CustomCircleProgIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentProductListView extends StatefulWidget {
  const RecentProductListView({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.query,
    this.category,
    this.isFavoriteView = false,
    this.isMyOrdersView = false,
    this.useGridLayout = false,
    this.demoProducts,
  });

  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? query;
  final String? category;
  final bool isFavoriteView;
  final bool isMyOrdersView;
  final bool useGridLayout;
  final List<ProductModel>? demoProducts;

  @override
  State<RecentProductListView> createState() => _RecentProductListViewState();
}

class _RecentProductListViewState extends State<RecentProductListView> {
  final Set<String> _demoFavorites = {};

  @override
  Widget build(BuildContext context) {
    if (widget.demoProducts != null) {
      return _buildDemoProductList(widget.demoProducts!);
    }

    return BlocProvider(
      create: (context) =>
          ProductDataCubit()..getData(query: widget.query, category: widget.category),
      child: BlocConsumer<ProductDataCubit, ProductDataState>(
        listener: (context, state) {
          if (state is BuyProductDone) {
            showMsg(context, 'Payment Success , check your orders');
          }
        },
        builder: (context, state) {
          final homeCubit = context.read<ProductDataCubit>();
          final products = widget.query != null
              ? homeCubit.searchResults
              : widget.category != null
                  ? homeCubit.categoryProducts
                  : widget.isFavoriteView
                      ? homeCubit.favoriteProductList
                      : widget.isMyOrdersView
                          ? homeCubit.userOrders
                          : homeCubit.products;

          if (state is GetDataLoading) {
            return const CustomCircleProgIndicator();
          }

          return _buildProductList(context, homeCubit, products);
        },
      ),
    );
  }

  Widget _buildDemoProductList(List<ProductModel> products) {
    if (products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Text(
            'No items to show',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    if (widget.useGridLayout) {
      return GridView.builder(
        shrinkWrap: widget.shrinkWrap ?? true,
        physics: widget.physics ?? const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.72,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) =>
            _buildDemoCard(products[index], compact: true),
      );
    }

    return ListView.builder(
      shrinkWrap: widget.shrinkWrap ?? true,
      physics: widget.physics ?? const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      itemCount: products.length,
      itemBuilder: (context, index) => _buildDemoCard(products[index]),
    );
  }

  Widget _buildDemoCard(ProductModel product, {bool compact = false}) {
    final id = product.productId!;
    return ProductCard(
      compact: compact,
      product: product,
      isFavorite: _demoFavorites.contains(id),
      demoMode: true,
      onPaymentSuccess: () {
        log('Demo purchase: ${product.productName}');
      },
      onTap: () {
        setState(() {
          if (_demoFavorites.contains(id)) {
            _demoFavorites.remove(id);
          } else {
            _demoFavorites.add(id);
          }
        });
      },
    );
  }

  Widget _buildProductList(
    BuildContext context,
    ProductDataCubit homeCubit,
    List<ProductModel> products,
  ) {
    if (widget.useGridLayout) {
      return GridView.builder(
        shrinkWrap: widget.shrinkWrap ?? true,
        physics: widget.physics ?? const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.72,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) => _buildProductCard(
          context,
          homeCubit,
          products,
          index,
          compact: true,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: widget.shrinkWrap ?? true,
      physics: widget.physics ?? const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      itemCount: products.length,
      itemBuilder: (context, index) => _buildProductCard(
        context,
        homeCubit,
        products,
        index,
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    ProductDataCubit homeCubit,
    List<ProductModel> products,
    int index, {
    bool compact = false,
  }) {
    return ProductCard(
      compact: compact,
      onPaymentSuccess: () async {
        await homeCubit.buyProduct(productId: products[index].productId!);
        log('Payment Success');
      },
      isFavorite: homeCubit.checkIsFavorite(products[index].productId!),
      onTap: () {
        final isFavorite =
            homeCubit.checkIsFavorite(products[index].productId!);
        if (isFavorite) {
          homeCubit.removeFavorite(products[index].productId!);
        } else {
          homeCubit.addToFavorite(products[index].productId!);
        }
      },
      product: products[index],
    );
  }
}
