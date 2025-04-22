import 'package:e__commerce/Features/Home/presentation/widgets/RecentProductLIstView.dart';
import 'package:e__commerce/Features/Profile/presentation/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, category),
      body: ListView(
        children:  [
         const SizedBox(
            height: 15,
          ),
          RecentProductListView(
            category: category,
          ),
        ],
      ),
    );
  }
}