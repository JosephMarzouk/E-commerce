import 'package:e__commerce/Features/Home/presentation/widgets/RecentProductLIstView.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            centerTitle: true,
            title: const Text('My Orders',style: TextStyle(color: AppColors.kWhiteColor),),
            backgroundColor: AppColors.kPrimaryColor,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: RecentProductListView(physics: BouncingScrollPhysics(),),
            ),
          ),
    );
  }
}