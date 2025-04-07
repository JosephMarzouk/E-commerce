import 'package:e__commerce/Features/Home/presentation/widgets/CategoriesListView.dart';
import 'package:e__commerce/Features/Home/presentation/widgets/CustomSearchBar.dart';
import 'package:e__commerce/Features/Home/presentation/widgets/RecentProductLIstView.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomSearchbar(),
          Image.asset(
            "Assets/images/buy.jpg",
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Popular categories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8,),
          CategoriesListView(),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Recently added products",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          RecentProductListView(),
        ],
      ),
    );
  }
}
