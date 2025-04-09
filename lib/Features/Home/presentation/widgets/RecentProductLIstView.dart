import 'package:e__commerce/Features/Home/data/models/ProductModel.dart';
import 'package:e__commerce/Features/Home/presentation/Views/ProductDetails.dart';
import 'package:e__commerce/Features/Home/presentation/widgets/ProductCard.dart';
import 'package:e__commerce/core/CustomCircleProgIndicator.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:e__commerce/Features/Home/data/cubit/product_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentProductListView extends StatelessWidget {
  const RecentProductListView({super.key, this.shrinkWrap, this.physics});

  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDataCubit()..getData(),
      child: BlocConsumer<ProductDataCubit, ProductDataState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          List<ProductModel> products= BlocProvider.of<ProductDataCubit>(context).products;
          return 
          state is GetDataLoading  ? const CustomCircleProgIndicator() 
              :
          ListView.builder(
            itemBuilder: (count, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetails()));
                    },
                    child: ProductCard(
                      product: products[index],
                      isFavorite: false,
                      onPaymentSuccess: () {},
                    )),
              );
            },
            itemCount: 5,
            physics: physics ?? const NeverScrollableScrollPhysics(),
            shrinkWrap: shrinkWrap ?? true,
          );
        },
      ),
    );
  }
}
